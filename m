Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E34E8AEF
	for <lists+linux-efi@lfdr.de>; Mon, 28 Mar 2022 00:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiC0Wwg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Mar 2022 18:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbiC0Wwg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Mar 2022 18:52:36 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E82E338A5
        for <linux-efi@vger.kernel.org>; Sun, 27 Mar 2022 15:50:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x34so14996673ede.8
        for <linux-efi@vger.kernel.org>; Sun, 27 Mar 2022 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=VSEH8Q3Lr+Mcr/0lsL1VFPftJp7ALZ21MKYEz4sry74=;
        b=GZKN/pcGaUedCujf95Jv4pHSCbZl12BFh6tDgneFSmw9gDEEb3Fx5sYixpRCtT3laG
         RMtuAcDWhnnGV7p+u8RrByNJj1nndmsbC9uBjNcsnK851mPis/Su59HY4dK6s07YJAgM
         Gd6CRDwuyOzNDTbq1S5phGnP5AydSsxlvkVYrJvddTwQjmrFou2/4FvX6o9/fS2/VXxe
         xv6SDg56hGBpi4GquhV5AFSSISJpKNz6dbcaHRaKnGTUxjeTsMO28bLSrPflXtDMHySb
         LmMBZSLOFfgOoZhLscBvN41kwpV5u79riAT58yH3cLCFU/dwbjfg7k5ZWhTxekZwfxpn
         6SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=VSEH8Q3Lr+Mcr/0lsL1VFPftJp7ALZ21MKYEz4sry74=;
        b=YYY9fQLFOVYwTZCwk0tmTivcCaNZbBTVfaMCpItMb+JdC2f2cMl+n7nIEDx73QQANx
         rM0xM5TagzaTWfYuAhTX4+LCIARWr4Ev7aBQeVAiTPQrZx9LByj0iKZwvSxFzfgXBcie
         m00ex6vucgqj1AsvXNsFbLJSciYp68Qhz1Dcbyyw2521LXlQPbSnAY5+fNru2o5BrkY0
         ADwvUkF3inJC/yaqUItBpSBsNg+i5iUAySvPSScWF8wU6emgBdfbdM42oaK6hNpVOh4G
         pFcgzdg0cPqJLvHcYMBfqjsz+b9C9rUKzfLaYJ0G7MZgtOenwTiQ76o1RPcVgLR81hqF
         I85A==
X-Gm-Message-State: AOAM533BG8kJl9Zf18KmDlOrz71azZObIIFjnLjBhtk+rp9hFnU49aF6
        FnHIZR4Cf/GhSb7WTqTykRuCAfLlXyui/vO4Ai8=
X-Google-Smtp-Source: ABdhPJwvadZvHZHTl1imgfopM/w4AS2+t3tP9SRvRAZ1wbWjyol+UnSh4kkISblyyyofGrgPHGMlcrup8R9JaYf6VR0=
X-Received: by 2002:a05:6402:50cf:b0:418:ee57:ed9 with SMTP id
 h15-20020a05640250cf00b00418ee570ed9mr12526934edb.37.1648421455392; Sun, 27
 Mar 2022 15:50:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:294b:0:0:0:0:0 with HTTP; Sun, 27 Mar 2022 15:50:54
 -0700 (PDT)
Reply-To: christopherdaniel830@gmail.com
From:   Christopher Daniel <cd01100222@gmail.com>
Date:   Sun, 27 Mar 2022 22:50:54 +0000
Message-ID: <CAO=CV9KP+m2qYKAMYi_FkbGe8KVnZkYKnizRjdBTpHM7MC66mQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4198]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [christopherdaniel830[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cd01100222[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cd01100222[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

.
I wish to invite you to participate in our Investment Funding Program,
get back to me for more details if interested please.

Regards.
Christopher Daniel.
