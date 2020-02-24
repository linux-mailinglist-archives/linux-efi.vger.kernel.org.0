Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2E4916AE01
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 18:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBXRvi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 12:51:38 -0500
Received: from sonic308-9.consmr.mail.ne1.yahoo.com ([66.163.187.32]:46847
        "EHLO sonic308-9.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbgBXRvh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Feb 2020 12:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582566696; bh=thAReImpSva7RFFsLtqtrbCHCILMa5YNHywwYFVQzsY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Kb4914yGGGfAEnlLrbRANziO0JpWxzsAY9DimNGsJlU+0zoD2QeedI9OKJyGi3JGlZFKMeL1CvYkFTKuVSmhb7lzoyofXRX2kSzgrUDm4keDqlGKVHEtZSOqal04Q73l+f1KMGa3LMgKVWN3BVjGv3XLhMxz6OzIlI+DA1s6yLpraz6hRNS83E71qTgKXsZYiazPS8jcj+kPkeYWFiMBUFdqXJOh/WGqQiQ0uUUWE+pwT1fAkYJR3Bw/FKKWFH2r0En2LavxF7rLY+pyS/zTZrPm74Kn0pfVuFFAtR3to6poqM8iwwnP1QAWEZI7yjsvJuAFHFgxdD5eaxflrLuh2Q==
X-YMail-OSG: illXvZ0VM1lYJ4IXSXvzX8PREbohhDj_DMaHJnBPco7A5BNPtdol.2gcMSi1axc
 50RlBv1HiPLM_IqzLLggL4x1r7ICb7UQX7LFukEqcYU3NFTapreR4frt39GrPQfONRsXsorb.F6Q
 gatlDOWTvqAcDHa6OUQaxV7dvHSmAIKBYgyUQZHh7Pn03nMTOjteLaHhrtUv1JAy5MRKLAL9CjKq
 uetJjcB278msGXVaxgZt_U1CDnIyDZ5W8r7Fl2.Rp1BC5E0RRnEUxjFq.tcaBqawoUVO_.Xm39F4
 jQueM7qFJLDB87EUxKtRRKz_BjmPukDk7cgY1Q.QU_Ylbeke4tDztEOLIxSJGMr8wUeb78F_3V48
 6B_jRcnarsM2d0NRM22ER8tvM9.fEOiVPDik_gMBETU9VjpP8zEjvB5EAoT6lqkP4e22bQEpzI2N
 2_fr3a.16tx9ELqoYgB8.1WlgDpmE7EH8moTbHr4yFvk2anNQkI8Qyj8Ess3uEBPxy5Zcywit7zc
 VaD6h4CxC4mb5VpgfOa77cih9q502EWJiynEkatCjNNj9EUEK6AhJ11ANgdGNn14O0s5qWL5O2zA
 UZAtxC4Q5_uYRUGvNd.fyLuipe7I.uBFMSxrC.j9beixwcapsfYAWOPkSOzgxTfD_bxUIgeLC6o0
 cv1kCKjgC5DV1nFVAvMBdC8b7S4gtlmlxh.lcLmx33Bu2kKZHYWSYJBwrsB6ZUU8l9jJRtFaWjFX
 lcW1TrRvjSa_dceXT6wlZlUZLRhvG_Mau1zPM6Y.FbWD.0S5OOPGGKa_vWwrjZBKv5QeS6h8XHzs
 XNLtVA0dfgAw9lRaWbLKOt1Qss0T2Pw18czj9r2twmMxStujlhUlPspAbxvyrMQjR9r7TXXCz4E0
 Bc8uIJ19kTr_GCGU4v_q1Eb2Oe.QnzeczHsSa.OaS456UHJEoaE6MZ5Q9N9CeDjQC3Jl.X1kv7Xt
 BrvTZfT8eb0qXc6R9m1AO0Dl1XIP9QmQcs7HqCMsrsfj.IPPkxuctVqit8Wf1Yig1OB3.KZg2NML
 JGEYlbB0WTqIARvm._hRjCBfhRbtbTE3LG8_E1Ss4ccXVvVKLwCnOOPAFQfxiuAp8NoCidm1IW9V
 XOugBoJkBYNaWVAxcfDFPhaC56Ssbz.v8WR.6TGSj60bypSk3M4OHPbJmJs6.EiIGiVVl5c2nyIg
 SECBt_42jfhaK_pgsR0aSU5dWszAKAaEFR0gk_gBKKn1j0fsYYNZTYLQafZqmT_LU2RstT5EHkEy
 nfk.nduGHqL5V12HkHY3VGJ8QQX5sqw_rSRC92HqnfiUkAsXsZDkYYDXfhhpcZiMQ.BHEpcfapUL
 Z5oAe0Q.9xw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Feb 2020 17:51:36 +0000
Date:   Mon, 24 Feb 2020 17:51:34 +0000 (UTC)
From:   IMF UK <cwilderra@frontiernet.net>
Reply-To: imfukoffice1996@gmail.com
Message-ID: <1280428065.7511950.1582566694534@mail.yahoo.com>
Subject: Greetings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1280428065.7511950.1582566694534.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:69.0) Gecko/20100101 Firefox/69.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



Greetings,

How are you? I hope everything is in order, our office has sent you a message earlier, but there is no answer from you, did you read our e-mail message? Get back to us immediately.

Yours Faithfully,

Mr. Peter Hambrook
