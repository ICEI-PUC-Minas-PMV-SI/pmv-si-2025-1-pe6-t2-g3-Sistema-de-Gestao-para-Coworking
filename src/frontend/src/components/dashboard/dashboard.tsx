import AboutUs from "./about-us/about-us";
import styles from "./dashboard.module.css";
import Differentials from "./differentials/differentials";
import Services from "./services/services";
import Spaces from "./spaces";
import Units from "./units/units";

const Dashboard = () => {
  return (
    <div className={styles.container}>
      <Spaces />
      <Services />
      <Differentials />
      <AboutUs />
      <Units />
    </div>
  );
};

export default Dashboard;
