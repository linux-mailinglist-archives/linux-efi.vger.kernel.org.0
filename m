Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5351BD7F0
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgD2JHz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 05:07:55 -0400
Received: from sonic303-1.consmr.mail.bf2.yahoo.com ([74.6.131.40]:35237 "EHLO
        sonic303-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726447AbgD2JHz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 05:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588151274; bh=q1Er/SdqxATomBDx27mJAnsQxxrJWpCL+Y8MaW3053A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=n/8vhjMYrIGjjTF6QxgIG7TsisJArEujJwsOpEy8p8RbTgBbvW83vDDvgsagNSx1xBxoPnjfUxSBf03GOvuasCuj2C8+ldT3s8BJ6IiNdd/jhWBF6YRbMePW2BmBbGh5LeomPF1AnSYnFjygyaV824/4omslRzHZkMeiAtRxm17hx472vu07as3BhxZ/TVqZojbvIvIyefx6w4YszdbuFQ86+hRXSykEdkT3RZCAq0MSyauCmV+U+BWteyKIpJO14vZ3Bcgac+LnnwjMav7uTTX9xwQO/OcCQCamivAlod3Z/6fxah191v4tzlpc8N8DoTuaOwB6Uq3oPLhwmcS+cQ==
X-YMail-OSG: 8VzAAn4VM1n3x2ftBykE1ErD.iq5EWOTERDWAmW5rHzsf7NOKf2f_sZyGxNfksv
 Db0EdCoWaXH_7XRvf_BK_nbPCcO4ncHe69C5.WCNr2r9NdFnBiT5iqLkcBhl_yV69.VhWShWI0nc
 po.cpn3RiOKUrK6b.rzjwdgotsM7gpF2S4CDSC7Bo6Gr29HYAgta0uhjCjEwJKiqf_Dl4rBXc7jT
 toQ99EdlTpQl9fQOV9AlunFXpJCpmC.wEZYoRAWdVspAIkxnNtlgOeT3jAC4oigDCM9BiTbjhrPZ
 43KYaZLG91Uh7hZduqC647tF79MGtst0c2XVsRIA7bwHRIzTzMM.9lb_s3ZAFHc4NtYhGo7T0V92
 SGM4LdYbDd_STWJR8IVgK5SQ3D.e3dt7DGxLhNQRQhVP6d0Z_Xco.yr8H.iIt.6O7osCSCm6OShO
 j6zpxu_gtGD8GkoG8.T.8ilxHSAZBI_ui31aE7LDsd7lezpjSBPeTWvxGl3Xb7Xdg.xLBEHt4Gcu
 Uq2OUzB_TM7oSexM8lwvuQ3ia1TTQOGbW5IwyEFIgVwZr6VfRiMK2DujNZJVk_KXo7PlTn0tXup2
 Q89LYWHflp8D5VGuWL795XiUUNZFoJYERI0nuijXp3QQkNEU8K0aa.lJdV3IUzwB_fnV6z091x0F
 TXGZ7bnZft.7Pf3jLIIF7GpvfItaNXYhIMag_FhXXI2GgIIhbnL3J9Aeu.q3zTSCSlWLX5Fot4dZ
 BP4xljVkq313d7l0kRAa1Fr.TwbYN2nWhlBdFe0KmjWu.P5vcYeZTYK5pfWu0RUWuHD3hEJSTdJH
 e7o6cKCCfqaqKUP4_6MNy8y8ZhSwadimzDOX1MaExc9lPxqGda1BWnvghpfmfiOK8du0BuVlrQOT
 eTS0GQbjo_eoxlxOW8ZRsuj8.YeASr9us6DO7ns0oEVvjSnJxBxg3D89Bunb2BrymR0xot3CuPo.
 WHgtKn3I4FEugUtJOzGpVMYAM5.QnGW66K5OZjGMCVelDIjR.C0wCawoXh4pZihvyDsW4f1iy39d
 tG_NWug_dKsj3Sq4QWv1Ecwz2bpRaiO2LWonD_fM56eaAZ48V9lMKeNosWu1DiFYnOSrmkYb.RpX
 xpAzn6OOnd.U5bEMGyrkeNPxpWXdNth4aqDz3T.hMTjhEY1lNJ3epuv.NabzyQfsC6hX2xcL34d5
 CVSXLGVL.0_tKZpYpUh3H5uemhIL9ZwtnSvcmkGUU1g05yAmZwxy.sBTjZlYOPjeZ0QjkhOjw.eJ
 wQ1oKFYGnTYbN9P4LLMY7KIlQzog1QzDRTrYzT3OcxfrLys0sTMpADC6eyvjnZnJ47MmCybeS0rL
 X
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 Apr 2020 09:07:54 +0000
Date:   Wed, 29 Apr 2020 09:07:53 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.mainaabrunel126@gmail.com>
Reply-To: mrs.minaabrunel30@gmail.com
Message-ID: <1836231886.1376172.1588151273253@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1836231886.1376172.1588151273253.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politician who owns a small =
gold company in Burkina Faso; He died of Leprosy and Radesyge, in the year =
February 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Mi=
llion Euro) Eight million, Five hundred thousand Euros in a bank in Rome th=
e capital city of Italy in Southern Europe. The money was from the sale of =
his company and death benefits payment and entitlements of my deceased husb=
and by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
