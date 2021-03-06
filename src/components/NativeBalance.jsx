import { useNativeBalance } from "hooks/useNativeBalance";
import { n4 } from "helpers/formatters";

function NativeBalance(props) {
  const { balance, nativeName } = useNativeBalance(props);

  return (
    <div style={{ textAlign: "center", whiteSpace: "nowrap", fontFamily: "Source Sans Pro" }}>{`${n4.format(
      balance.formatted
    )} ${nativeName}`}</div>
  );
}

export default NativeBalance;
