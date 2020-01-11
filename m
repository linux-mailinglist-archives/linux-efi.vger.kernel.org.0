Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53843138361
	for <lists+linux-efi@lfdr.de>; Sat, 11 Jan 2020 21:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgAKUAD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Jan 2020 15:00:03 -0500
Received: from sonic304-22.consmr.mail.ne1.yahoo.com ([66.163.191.148]:36607
        "EHLO sonic304-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731013AbgAKUAD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Jan 2020 15:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578772802; bh=ccCAWoSF5BLfDOatu3qpU6l9KI5KeJz6QggOEqZVG6E=; h=Date:From:Reply-To:Subject:References:From:Subject; b=jb5zCxttEI1w6ueBMvBrBIQFNpMURr8lX4uMr/XnJsZXxvtjol6pmrUX3lgJ9ZsmIEYIujhkGMtcckbh1DLLoV4wcK1gXGigPl6EFVHJp8858aA2kr/2lIcRQC6rBf/lOgYhD5XejJyevUKqwZnjXMCud6PyHt/dtDiv0276JHYhm5Ai1tDoOWZpQwQCMPhDNH60N6uFMY7+aUx/sBvuO059MVIgaCXzhJbsBXblyxJdXspaVBvYe7HCTfldCV9cWA01hrGcYBpvio5TF5S5nG29GJ8DwCo8s0OuN13nDkV5hUb22x8D3ixCD9YqkAw/g+kleEYa7OmsX5leIIgOrQ==
X-YMail-OSG: RzCymNoVM1nV3kpIlx4JIAWQWUtbtQA9MOOY1AwIr6G58ggl92JLvUEMHl8tw1v
 1IIAm7ba7QorF0csvHXcoWOdAYMvvU3kx3rBCbqCYfsbEy2hrqSLFPhDoX7zEIa31ooHk7huF..K
 UoyFspAqSSsxhSA9tX1b8XcCXizkV2.pKPAH0ueQ5O2bDX2QbzSXAgZwZ0eJHYu6Yu6V_e84l_Tw
 PWImUHyUUwU9m0WZYxIRG4N9Iy30kFn8hywF8Dr10oY4ChhKQzGwrpXhcenYQo0EdLtoUg5fOen1
 j0B5dAMVvl54KAMgCyuphz1k8TEHcBQSP7c.hyx3WsvGqjN7DSRAzVlRcb6F44s4xLcH5w45uNnr
 8nBPLisA4YiHxLl7ThkgMrLQVbT2CscII87o85izdwOwZujNPZgHRAQuYXz_LEZwvYt5L.GhQI54
 kPYfLeaLEP1T_SDfLYIxUjnEMjwZt4n3fBkbtEfYxGYyzAJRfbucaaSRfufNLVmZ90eBcRcQ_13d
 CkWc89dKPgWCthLzV_eXW0zix4sQOvWn.FwuFdP02QJK8hCxfE5cjtzRZINMKbmy.Z2m.GoE2ofW
 D2ORTvYpJ5ktc5l5RAdvngNKm.CFOiqAd527KfjdgMATuUNxh1XivAayYlBQMJ_I.5Hg4v.8E3Bf
 xLYPHmxaPlVTfXxKQJh0o9UZS42HfUCOCku01PyKRucVzhUD5RRf1G69aYMdeVefB9yG..WL7aWK
 GBoq0aDil8ZIeAGTGaPwpaRX9yVDHtStyjrX2_KLBPNYKbWyXWPtHR7tmB.ZvNg77lZu9eH5RNhr
 DTdk0hI0ruovDPwMzyeLAPoKNU6ET.zxfQ4oBpzTmsNEKF8GlJD_pZ8_iogSQDyv9KJhc1w5j7Aa
 8dRRhkXpKZhlT9pxreJWKC6sIYEA_DnaBMjhiJv4TokMtbGV9wVea7ns0HjhlJnMzadK780Ln2VC
 meFnywqrZFQ_0GkW3GXAOp_i6S5NtMMLCtMoRT_2etJinxe5pRURL1kF1YlgQ6s67jvisTiMLCTl
 _HX4ikIRT02HpOncw6Vtv6AHQtgQXXjHpdXhyOmHKUxZ9_k3xQkP.gxWUM02tiGMzaqIXV8Smn6A
 YDo_Wn_k.ir94zZIFX3ttN41QSO8I8z2.RsYxUyoNFWu.vJZ8bWXpd17gRj7gvt8Ajm4HtO7Vj0O
 trJzRYObYuxyXZpU4F8KajHNmp.x3uet87Co2gJcWt50Sn3Y1OOAs5kRKwkcz0ua_bGjKIF9dVBO
 Toad0e_Vv9PMeQC83_SaRqPpTB1MkJcx2TD9KWP7DsV1V4v19ZQpx7KmZpLPtCkwEKVOl_kgQMo3
 PrhrPFFe0M6h2caixBVhBSx2RNhvJmgJhxA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sat, 11 Jan 2020 20:00:02 +0000
Date:   Sat, 11 Jan 2020 20:00:01 +0000 (UTC)
From:   MRS SABAH IBRAHIM <mrssabah51a@gmail.com>
Reply-To: mrs2018sabahibrahim1@gmail.com
Message-ID: <158270501.10165773.1578772801489@mail.yahoo.com>
Subject: Compensation for your effort
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <158270501.10165773.1578772801489.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dear Friend,

How are you I hope you are very fine with your entire family? If so glory be to  Almighty God.
I'm happy to inform you about my success in getting those funds transferred under the cooperation of a new partner from  GREECE, Presently i'm in GREECE for a better treatment  and building of the orphanage home projects with the total  money.

Meanwhile, I didn't forget your past efforts and attempts to assist me in transferring those funds and use it for the building of the orphanage home and helping the less privilege.

Please contact my nurse in Burkina Faso, her  name is Mrs. Manal Yusuf , ask her to send you the compensation of $600,000.00USD which i have credited with  the ECOBANK bank into an ATM card before i traveled for my treatment, you will indicate your contact as my else's business associate that tried to help me, but it could not work out for us, and I appreciated your good efforts at that time very much. so feel free and get in touched with the nurse Mrs. Manal Yusuf (email:
mrs1manalyusuf@gmail.com ) and instruct her the address where to send the ATM card to you.

Please i am in the hospital here, i would not have much time to check emails or  respond to you, but in case you have any important message do send me as an update, i might instruct the doctor to check it and respond to you, meanwhile, once you received the ATM CARD,  do not delay to inform me.

Finally, remember that I had forwarded an instruction to the nurse on your behalf to deliver the ATM  card to you, so feel free to get in touch with her by email  she will send the ATM card to you without any delay.

Thank you and God bless you.
MRS SABAH IBRAHIM
