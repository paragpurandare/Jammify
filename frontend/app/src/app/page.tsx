"use client"
import Image from "next/image";
import { useAuth } from "@clerk/nextjs";
import exp from "constants";
import { Button } from "@/components/ui/button"


const Home = () => {
  const { isSignedIn } = useAuth();
  return (
    <div>
      <h1>Home</h1>
      <div>
        <a href={isSignedIn ? '/dashboard' : '/sign-up'}>
          <Button variant="premium" className="md:text-lg p-4 md:p-6 rounded-full font-semibold">
            Start Finding your Partner
          </Button>
        </a>
      </div>
    </div>
  );
}

export default Home;