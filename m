Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF6A59EB8F
	for <lists+linux-efi@lfdr.de>; Tue, 23 Aug 2022 20:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiHWSye (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Aug 2022 14:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiHWSyO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Aug 2022 14:54:14 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3FB11CF0E;
        Tue, 23 Aug 2022 10:19:48 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3376851fe13so364340747b3.6;
        Tue, 23 Aug 2022 10:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FC6hnZbwBtmw6oIIpxsgV+B+7mA53uX/U4iba0ioviU=;
        b=Sgp1vZry3w9ICcogpNTZspMfoxePVLCrdUka3sGuQ6bDG1ink0vr+w4Nh3PK+2r1Tp
         Ei03BVFmD6+0PyA9DSbbsq0Zyjj/EalGbu+0qzqQDGQP3tLE165VQC1LDrTOWKVdw16N
         TTcWGMglgrXNaRbmbSINtAwmMzdbCqKIULUfmGTjvhzskVwOgrx6v/hXekMejq7nnnS9
         7kmJkkhhjS+7P01yH42iwM6/JGFbyh5m2iBkWJZ5YjKBNl3uR9Gj43yga0l/T17lCf8D
         UcozXm82LepA7nSwn9gkQREx+tReUMz8tkgRqmQY58wPHW4WypYE6spYluHko0TlToQS
         i6/g==
X-Gm-Message-State: ACgBeo0TSa5nxDLFNQFIbdFvAjxprJv5kbwJhnJI+wIReNqQRh2FzrQ2
        wG/6LkrfQZW0RsDK0spAFggPFgtTBbrd1rvODZg=
X-Google-Smtp-Source: AA6agR4cTX5F8PyOjA1279e807GkwUK4KIWkE3KWOkDhaVt50kdCpplTQD6zGvPNuPABbFQ+fJ2lrIz5unWXRJ3z6zg=
X-Received: by 2002:a81:9906:0:b0:2db:640f:49d8 with SMTP id
 q6-20020a819906000000b002db640f49d8mr7298558ywg.326.1661275179229; Tue, 23
 Aug 2022 10:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220822154048.188253-1-justin.he@arm.com> <DBBPR08MB45381EB46B4714E0DCE63ABBF7709@DBBPR08MB4538.eurprd08.prod.outlook.com>
In-Reply-To: <DBBPR08MB45381EB46B4714E0DCE63ABBF7709@DBBPR08MB4538.eurprd08.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 19:19:28 +0200
Message-ID: <CAJZ5v0hY5bA8iB4KdnZ3te8KOML8JQbPVs2Laaq7Lz=bh1amMA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/9] Make ghes_edac a proper module
To:     Justin He <Justin.He@arm.com>
Cc:     Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 23, 2022 at 3:50 AM Justin He <Justin.He@arm.com> wrote:
>
> Hi,
> Sorry for resending the v3.
> There is an exceptional interrupt when I tried to post v3 at the first time.
> Maybe it is caused by a comma "," inside the mail name.
> E.g.
> Signed-off-by: Some, one <someone@site.com>
> Looks like a git sendemail issue?
>
> Anyway, sorry for the inconvenience.

I've received it twice, but no problem.

I need Boris to tell me what to do with this series.
