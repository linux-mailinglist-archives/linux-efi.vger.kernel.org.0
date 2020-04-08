Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7611A2B77
	for <lists+linux-efi@lfdr.de>; Wed,  8 Apr 2020 23:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDHVyV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Apr 2020 17:54:21 -0400
Received: from sonic306-21.consmr.mail.ir2.yahoo.com ([77.238.176.207]:40945
        "EHLO sonic306-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgDHVyV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Apr 2020 17:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586382858; bh=q1Er/SdqxATomBDx27mJAnsQxxrJWpCL+Y8MaW3053A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=nEBVwclaMtukzYyl98uwbeN/NvQ3WKTVywa4q/5SWeH0IROEabvmGqcqNPoWd8R8hIKzuRE6WtmNaGZvpQgGfxGMebrSnMaQ+8+F8TU5PV8e0DQ5TzKdLOvAMNtEvizIQ2LzAYOonD7xGQr558sCnr46TnMTTyRFYNryvxf9XLDYquRoLk6gLWNsIzSy0l+W/54rvqEaEVN4ET4y1N1/HOJ0Y28c8Y/Ir1u72X6hj2KGboOO70aBChXIE/10vBMyE+LxbRd68QkGN0G1k0augma3Eaax56Ed5C+lMHGi39XhP7OpT6LZfaDDtHDsjLaFwkkeeMnjk82rZAiNhC02TQ==
X-YMail-OSG: 5usHcjwVM1nCnT3yED6mbEH6lePu6kYsBLbQe2Zhfkp9uY1_J4Jnu37vdUChAG7
 DYp4x8xq63ATPkgCRvTzXGnH1DZpdxhHMt1zNN8bZP7KLhKAPfyuFYR.7qU._m5Whn3r_7Yiffh_
 _VwUZCqe_Mia7h2p217r6NS9_JwSM1w6N.dA6R2usLgHoOxlffAYbmKwDCma5Iii8WpE8_ZLkknk
 z_TIwpuXNsY7OPOCNOcTSefWlhbh7I3e0Bq4HxxpNG9Z_yOzyQQWqHVqfmxp2vHTNhmjlQE_F67i
 R5kD7B6x9aKBpQPy7U1_M7XE.KvppKSROqb0TE_2f0wU0Iu5HuoX1Hpt0Cr5DXDHQEmlw.nEAMzM
 1_2z3Moy9DF.9M91Rmauc_C_Ldx80BAAWnzsF8cBVwcFiM7BDJFTwvhU3M8hTyI.BRcK5UJXeNwM
 YLt_UFHxrdbSeZE5WafI60FuQQGLlnuC_LRrqLmO0PBB24Rj6FepZXczBfGChek.vFfhHOmCty5f
 n14GpzTyZOAkfmE0PKOYM0ZAz7EFd360poxm37cazpvs0P_ajmEUYVxHndPt_SkahxqbWK6d3.fc
 ZK_yZ7em5rXMIUvXbb0o1XG2R0tqTZSgChAZA8gi6CkipJhB99NUSKqTJ_M_W0cZbGdWRs1o3RHI
 Z2LIZEfE.r4uG4kOOpVh0qshEHVmLgfS_ZuBvTb2RcSZkZbz01XV8duUi1LHaOsXClPitlzWPQak
 CZI6vrJOIGYbM__KbqEvFsYoRTWHbeXpnpXr0WgxEnMUSg3QmA9CP8CBghUCDC3Bvct2ulnCLviu
 umnbosw5Nr8VxS5hGaUl5UBk7bQrs3b9dm_DC5_3giavBiSzjmX0krV5FpqESSTnG5cgVe7qr9jf
 RkGugZrIAT8v_cM90jnEzq0OSxxLPIxS3AJCXZOvXVmQSMlAmBSw2rMIxd8twd3bkvVVv97aXODr
 3R8ByvfYoC6.dR92d_YyeApvsIRUgCok6c.vCB3Pbe3tAz1a.xQTyZu5Mp247jpADvGtBrcCwD8.
 HXazPn1b_QU4GJvh2vB7kgwCLvZmqVJXCqlmZXOVAeFeN2mubdJymVJPhIfY.qjAfy9kqwMt9qpW
 LRB_CxKwTPxRqhjHpfaaZU.BwH1erjhP005SyNZpNL5rLT4F4bCnR1VOhSz4YnShiqUovc2LFFVR
 BLQGVJiQnfoIF_HxrYo3rH_.I.hPj6c_8FlE66165mjvsC7eyDBgd1vgWXKakBI7ToIIKV2aihry
 PG6hduUN8HZ51IrAv8XuktLZUippJsMKVFiSa_pGFe9V_qBAQtvdau1muiQ4rNV4Klr7x_5pOhGQ
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Wed, 8 Apr 2020 21:54:18 +0000
Date:   Wed, 8 Apr 2020 21:54:14 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.minaabrunel209@gmail.com>
Reply-To: mrs.minaabrunel30@gmail.com
Message-ID: <1914428890.4990332.1586382854104@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1914428890.4990332.1586382854104.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15620 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:74.0) Gecko/20100101 Firefox/74.0
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
