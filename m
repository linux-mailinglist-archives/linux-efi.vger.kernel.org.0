Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD6D78BA5E
	for <lists+linux-efi@lfdr.de>; Mon, 28 Aug 2023 23:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjH1VfX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Aug 2023 17:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjH1VfO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 28 Aug 2023 17:35:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110B186
        for <linux-efi@vger.kernel.org>; Mon, 28 Aug 2023 14:35:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c479ede21so3109817f8f.2
        for <linux-efi@vger.kernel.org>; Mon, 28 Aug 2023 14:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693258510; x=1693863310;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wh77ELpaghlUL85iKQZLobA572ak3oWVH+NHgjHqWqs=;
        b=FWJmCb4CXuXddvxtUHmcNO51BFbDxYHjoJAO7kojFOD11tIlxu/hociWjJaAvJKbIF
         8oGkIbBA1qqUQ/SEVPIy3u4Lu9i4WGmCCTbErx7flWGZ87DuzActLwk4xP7kAA/VgTnV
         N8oK1hUe461Cgd9utTF13Iih/4Oqi2S5DyRGVTdhVGit3KdyRflSXC63kmQ/scAj001p
         b9BqvCdfpDTzq4JeJtu6xXhCOjRceOlcran96KQZSvrViizpOxEHR1CT+Ae/OBpHXyrh
         QTt/X6QEUHo6GEoVewIX4BscS7rxTdcJiUiArbamfp8yz4dcOquoTY8Jg8LBeAFV40b6
         Sbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693258510; x=1693863310;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wh77ELpaghlUL85iKQZLobA572ak3oWVH+NHgjHqWqs=;
        b=DnBlRcMhz4V0cMjPRIcAFNJWq7jDsylH2fdAgpY2N7O9Viap2BBEUqbqo5AGvhgOqz
         PTpdGlOGDSrPACHiFSMUt5+DwR3HBNTVeVsm6+san/lwsdLTgYjOcuGt9/1AhY/Po5sE
         cFYJHHcHq9nKRFwdGyI0936dnG0dkrAJrY/DVAC1V7x9CKVK8dXLhW9JBDQZGYuEZqT2
         VC8XUXS5rczqW6Ox/t70vKIQCw3XuOA+XNLj16MQ1XR0zvnmf7TVXMPkLQVpM7qxDnca
         9CMWzqQiqE+XNfMw2XbpBdq79XaUPDE/c8mVJUkBtwt1IrLcI3+LXthvHGMhm1ZvQBIq
         091w==
X-Gm-Message-State: AOJu0YxEa5IaqjzmQmZVFL6W0jloGookS33uaoJgonErT8fRAcFDPESd
        hZQVi5aYw7tACjoyZikMI/WArIxOVMdDGQJPklo=
X-Google-Smtp-Source: AGHT+IG1z2Z9KmHRHKVW554gFmbcclR4Bb13KuSQWGIKUrS0MSizBXjRnQ1L9LISXTFCkxBggudwKxtMCLNLylwez+M=
X-Received: by 2002:a5d:684b:0:b0:317:6310:a616 with SMTP id
 o11-20020a5d684b000000b003176310a616mr19566115wrw.36.1693258509680; Mon, 28
 Aug 2023 14:35:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7412:461d:b0:df:4ad0:893d with HTTP; Mon, 28 Aug 2023
 14:35:09 -0700 (PDT)
Reply-To: chrislucas@skiff.com
From:   Chris Lucas <dr.filipemart@gmail.com>
Date:   Mon, 28 Aug 2023 23:35:09 +0200
Message-ID: <CA+L9BwxcJuvwZ4aSyv7ksvkBohCJrBBOe1vmcackQ6Qks4nSGg@mail.gmail.com>
Subject: Greetings to you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,T_SHARE_50_50,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2a00:1450:4864:20:0:0:0:42f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5918]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dr.filipemart[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_SHARE_50_50 Share the money 50/50
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

-- 
Compliments of the day,

How are you today? My name is Mr. Chris Lucas-, I am a Branch Manager
with Lloyds Bank here United Kingdom. I need your urgent assistance in
transferring the sum of (US$800,000) (Eight Hundred Thousand United
State Dollars). This funds is the profit I made personally after I
approving loans for 2 offshore companies in January, by passing
banking standards. I took the risk because the two companies agreed to
pay back the loan with high interest rate which is the profit I made.
I have since then deposited the fund on a suspense account without a
beneficiary.

I contacted you for this opportunity, because I cannot connect to the
funds which will raise an eyebrow with my bank, hence I seek your
parnership, to enable me present you to the bank as the beneficiary of
the fund which will be for contract payment. I want to assure you that
this is ABOVE BOARD as my bank does not know about this profit I made.

I intend to part with 50% of this fund to you while 50% shall be for
me and I will also like to invest in your country. I know I took the
whole risk to make this funds but I choose to share the funds equally
because I know it takes courage for anyone to partner with me
considering the magnitude of funds involved-

I will appreciate your timely response.

Please kindly provide me with your personal mobile number for more
conversation to enable us reach a consensus before I introduce the way
forward.

Best Regards,

Chris Lucas-
