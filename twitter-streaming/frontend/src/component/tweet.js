import TweetCard from "./tweetCard";

function Tweet({ recentTweets }){

    return (
        <div className="my-10">
            <h1 className='font-bold font-mono underline text-2xl'>What are the fans saying?</h1>
            {recentTweets.map((tweetObj) => <TweetCard tweet={tweetObj} />)}
        </div>
    );
    
}

export default Tweet;