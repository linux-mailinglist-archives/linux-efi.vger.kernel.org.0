Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90C827A934
	for <lists+linux-efi@lfdr.de>; Mon, 28 Sep 2020 10:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgI1IB3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Sep 2020 04:01:29 -0400
Received: from sonic306-19.consmr.mail.ir2.yahoo.com ([77.238.176.205]:44742
        "EHLO sonic306-19.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbgI1IB3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Sep 2020 04:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601280087; bh=MWL01jPVJXuBFzguUnxzZVCMkBAhTvIWLeZZqdlFV60=; h=Date:From:Reply-To:Subject:References:From:Subject; b=hAWbRGiyUoBiCBfuJnSDc6LrDp+B6FyMZqEUxGLdERJ2Ug9ChEtqq6t41h5rWv4aVcD7+UEN4fBu9MdCjki8k9jcEyXasqgHlL3nx1rgdwyriGRjSHjAn1iRM629tkkRP1KmDCNK7O3lNbyGK9jkwXcnJ6dKfe+1fHrK1lYu1k5+6NXpF5Xg0F+4ZCf0kakPqdxCyEgptDw9LkxWYuSbLM8NER6XZbQ3iY+177zW73J4h2MA3eroodVMT+s1V8QcLGsibUbolaOcD6oXA1KsHo90ABx9pynh1LP2PJD98uZ3MJqjlNwku5UaipHAG8kEtk+lhzQY8gZ5dvd002fWvw==
X-YMail-OSG: Ulbq1ykVM1kit9dG3YGdVzGqO1QbRRvKZ2GIsPGcz2Rv.aBGl6Fa2.sVjuSfO8y
 wO_0Hu0u5R7.CFxMRsSMAai6AEaa_XpDH6uEDfFrDK2ZSqShsEL2KM1_ayG9zVmcvUfds_vWgPOt
 kJXMzprBILiCfLhrm3zNzcNFYheKBtu.LaWvHLBjDsMf7b2W1XMriAwCc7rgliWRjgLdcdFA5kVu
 wtPtSCD7i9zjAegroSPWeUTQ0vdoNVqvvl3MRYY663T_G0ddPSpSmabQEpEj23NoSKalqU1O6TBp
 yw3XOupdIuDJAX2GdZITccw2DTBZyQuu1ONH_ersPijPTxIWicYdLHA6z7K0x1Hv6ebJo502292B
 Xw2Hg9qww789TcgWaj5QusUKaY8GM8nRjbKNbrCsGvG3.8P.fE9XDtIwZLIMBcQp311CdoWzjODh
 iSJna6BPj6MSXasJZo05iux3_p3v33y8dRdbcRtlpDUvb95Ypb5z4XSvr5ggY1MJ3KZSH.vBrfUf
 vKmtVAM7iZEfllI0PesR1b8dZXSP8XG6gGp00pLi7fU9jthuEd5pRR77talapy_jCZ_9_587isgo
 EFAW09KlrW8W9j6mMCYHrNCb5Dd_oQ6z5PDGvBfv3RVhd9gFNl57L9Fu5JQe_uDTW5_LUgHz7ENc
 5q72WklV1TMHZlJGI7bfT5f0I3Erf5D1bjP1PG947MJwY6_XvQGPoZ7mhqgD5Nm8xZUgXCkYqU_P
 OHOJ4WncwUid1XNu2k_jjt3cVYz81IeYw76bW_JFo5t1Tf0tG7xbcy5W2XoSLP9iP9jeP5yDcMCI
 i4vEyfVE3IsheKS.wO1PPv33nL1xPxrllXD6JM43GJt6bYRXaOIWob.asbFHvFvMgDhJxIoQzDMd
 NAXEULxMP_ZdMiYDHo9g2EjbLlfARtxpXezdzw0AtwqPAz.gVD7G.97dcteWfSBtMkvjp2w62r1n
 6GRhb2fo.7IbgWe_Oaswl6mh05ekrOzpzDCKtx39Uk2wahiEsT0tEeKDVWQAHJ5RtxdZR20Hz.AO
 zzuctwjEqfB4WMqoskIIeh5J7QG2KC_YhEVIfp6G3p2MANhKIZXBLwR_s8MzU.hGMRBYLiRbV0FR
 PNKCfx8qtCcWTgE8cMSVS.TwXnXrwIi9Bkl4u7ms5UYzWxSsNIK9fQeo1OlPg9oWwSwdPksITwYg
 aA0E9OpZnelDxjzZOl7F0tAdu8rkiYChbPkV_ttGTJAlCFKd5OKMF1n4MyGB3TYafwq.WCvyN04E
 RCMknf7DWM2GDodwic76Y6B56ynZJH_IWCkJv9KB_RtJxJ_JmXdwB0hFPgl1wRstOqaxiFk7zO26
 6FFmrAehkRjcnd96Eip0rPVfDCnXHqidEP2pm6HhyMUfK0VRrDoS6tMWZMS_S0kR8FIul7iE5bRM
 e5EJy3_Fv.efQltv3sbGLMp_xb.rxhlyRXresbn3RMLUz93mV3n5WFvecpdbEWw_WSf1Vs_ia
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Mon, 28 Sep 2020 08:01:27 +0000
Date:   Mon, 28 Sep 2020 08:01:22 +0000 (UTC)
From:   mcompola <visacarddapartbf@gmail.com>
Reply-To: mcompola444@gmail.com
Message-ID: <1047269090.2251379.1601280082699@mail.yahoo.com>
Subject: Dear Friend, My present internet connection is very slow in case
 you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1047269090.2251379.1601280082699.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



Dear Friend, My present internet connection is very slow in case you
received my email in your spam

How are you today?.With due respect to your person and much sincerity
of purpose,Well it is a pleasure to contact you on this regard and i
pray that this will turn out to be everlasting relationship for both
of us. However it's just my urgent need for a Foreign partner that
made me to contact you for this Transaction,I got your contact from
internet, while searching for a reliable someone that I can go into
partnership with. I am Mrs.mcompola, from BURKINA FASO, West
Africa .Presently i work in the Bank as bill and exchange manager.

I have the opportunity of transferring the left over fund $5.4 Million
us dollars of one of my Bank clients who died in the collapsing of the
world trade center on september 11th 2001.I have placed this fund to
and escrow account without name of beneficiary.i will use my position
here in the bank to effect a hitch free transfer of the fund to your
bank account and there will be no trace.

I agree that 40% of this money will be for you as my foriegn
partner,50% for me while 10% will be for the expenses that will occur
in this transaction .If you are really interested in my proposal
further details of the Transfer will be forwarded unto you as soon as
I receive your willingness mail for successful transfer.

Yours Faithfully,
mrs.mcompola333@gmail.com
