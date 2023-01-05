Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5029C65E481
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jan 2023 05:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjAEEOQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 23:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjAEEOO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 23:14:14 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8DE34765
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 20:14:12 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id kw15so87312710ejc.10
        for <linux-efi@vger.kernel.org>; Wed, 04 Jan 2023 20:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3HAQ1iwdSNYG5zv8w9IpRfitR0iS5MN5Wkm6OyHQWY=;
        b=Um/lJQZf4DlUZDxJYv+vg9xQ432z/eRHqIK8PSuF26/mnG0LmKRhL2bkxCQCmc27vA
         lqKw3PXsdBIb+fMOe1w/aG290RICnTh1ktSqHaE5d08iaOooxzZ4IjXKbJEzktEyYPgb
         ituuXMrdnT6o2Ptkj312nDFNsm5shOVV8uSUZ9O3PTT7LFb+xGqzzooXJZkVJyIL2u9j
         gHDdURb3xofBYHxj9294VxyglvExECkIjIC9/cGnGythooPNEotw39S6ImBNLLDSNBL8
         V4CtKroe+Lz5nInGcJp3A2Ew+ihuRz6BTE82uGAiimJOczWyuF5y8ZDbWMN/HzltNG/z
         OhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u3HAQ1iwdSNYG5zv8w9IpRfitR0iS5MN5Wkm6OyHQWY=;
        b=czCh05vC98Gb9GuXAjOPOUoLaWb2yI7FaldpbQynsVmF+KQPW9uuTJjFi4q7D0Sdkf
         GgL0wMUu2x6jtGcTZmpO2Buhst9Vv3H8p05eFHMzRY82C3+lGlKjhKKq65UpxAIyINyK
         OXKKrdKVrkUDeiktfb/P9mCczUvakFVGSvrkiWOJNc13JnzYB0CU2Nh+qm+eN4WDVPns
         DIQyU1YXhqc4C02pQm0d2L4lM5g8ME2uLkMROJchooHmWAX/S09YCaGC/cuqwLrj/h23
         r7h/5RwKWg+qf+/Ve6S1j3eeAA9kX4ICKhShlbjJJh/f5egtOcfQc5DDzNWyeJJx2dyS
         9QsQ==
X-Gm-Message-State: AFqh2kr+Tza+/vfxuQYT2wJQJhH64V9E8EvxGHXqcv9UYuUtXKUyiBk6
        wgVg/WaV9jQ2el4lPXyPJiwKxsOw0qlyAySV2Xk=
X-Google-Smtp-Source: AMrXdXuC/QM/0mWseDYli/9IJ30CEtf3el6sUzZ2Qs5VJL1+w0+LlPNG0+VlDoHZbsU1+ifS7mdrYK8Y6Ala66BNqy4=
X-Received: by 2002:a17:906:1b06:b0:7ae:16a9:e4d7 with SMTP id
 o6-20020a1709061b0600b007ae16a9e4d7mr4024983ejg.574.1672892050623; Wed, 04
 Jan 2023 20:14:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a98:9d8c:0:b0:1a0:898:2a6 with HTTP; Wed, 4 Jan 2023
 20:14:09 -0800 (PST)
From:   Ainamagara Docus <kawoomadocus@gmail.com>
Date:   Thu, 5 Jan 2023 09:14:09 +0500
Message-ID: <CAAmdC=eUMKyOJFjt6=0hhRry+Y2brT8QcLhunOLUYtaKm_gQXw@mail.gmail.com>
Subject: =?UTF-8?Q?Happy_New_Year_To_Your_Contract=2E_Frohes_neues_Jahr_f?=
        =?UTF-8?Q?=C3=BCr_Ihren_Vertrag?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,MILLION_USD,MONEY_FRAUD_3,NA_DOLLARS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:641 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5880]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kawoomadocus[at]gmail.com]
        *  1.5 MILLION_USD BODY: Talks about millions of dollars
        *  0.0 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.5 MONEY_FRAUD_3 Lots of money and several fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Happy New Year And Congratulations To Your Contract Award.

I am writing to inform you that the Secretary General of the United
Nations and Board Member has made a provisional decision to award you
a charitable work contract through the United Nations Data Online New
Year Selection Program and your name was selected to award you charity
work AND empowerment contract with the sum of $25. Million USD, to
serve the communities and neighbourhoods where the United Nation can
not be able to reach out. The United Nations can not do it alone and
we need your assistance to make the world a better place and fight
against poverty.  Contact Mrs. Ebert Achy, for more details and she
will also direct you to the important areas you are going to work with
the fund. Below are the details of your awarded contract.  Mrs. Ebert
Achy, is ( ebertachy@protonmail.com ) contact her now.

Description Charity Work and Empowerment
Contract Number UN/00497HN511HRXJ
Awarded Amount 25 Million US. Dollars
Amount Code Secret  Number Q2563DK

United Nations
Data Online Program Department
Midtown Manhattan, New York City, USA
