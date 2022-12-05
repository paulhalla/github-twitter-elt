
import './App.css';
import { useEffect, useState } from 'react';
import axios from 'axios'
import Tweet from './component/tweet';
import { embedDashboard } from "@superset-ui/embedded-sdk";


function App() {

  const [recentTweets, setRecentTweets] = useState([])
  const [access_token, setAccessToken] = useState('')

  useEffect(() => {

    // get the most recent tweets
    const init = async () => {
      try {
        const response = await axios.get('http://localhost:9876/recent_events')
        // console.table(response.data)
        setRecentTweets([...response.data])
      } catch (error) {
        console.error(`An error occurred: ${error}`)
      }
    }

    init()

  }, [])


  useEffect(() => {

    // get the most recent tweets
    const init = async () => {
      try {
        const response = await axios.get('http://localhost:9876/access')
        setAccessToken(response.data.access_token)

      } catch (error) {
        console.error(`An error occurred: ${error}`)
      }
    }

    init()
  }, [])


  const fetchGuestTokenFromBackend = async () => {
    try {
      const response = await axios({
        method: 'post',
        url: 'http://localhost:9876/access_guest',
        data: JSON.stringify({ token: access_token }),
        headers: {
          'Content-Type': 'application/json'
        }
      })
      return response.data.token
    } catch (err){
      console.error(`An error occurred: ${err}`)
    }
    
  }

  embedDashboard({
    id: "19226426-1072-41af-9a76-5320e372503a",
    supersetDomain: "http://localhost:8088",
    mountPoint: document.getElementById("my-superset-container"),
    fetchGuestToken: () => fetchGuestTokenFromBackend(),
    // dashboardUiConfig: { hideTitle: true },
  })
  

  return (
    <div className='container my-6'>  
      <div className='mt-4' id='my-superset-container'></div>
      <Tweet recentTweets={recentTweets} />
      <h1 className='font-mono'>By Rashid Mohammed</h1> 
    </div>

    
  );
}

export default App;
