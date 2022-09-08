Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673615B18A1
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 11:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIHJ24 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 05:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiIHJ2y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 05:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723CFF5C4F
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662629332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6pyH+1DweH0nMohfwtdsKO0eIInaeC+MrJ2yhdvIVIg=;
        b=fzbKTVRHRVoLSzaHPiHz8nS42z9XfBBowzh+/NmdIHFlcFvCxJeYJHMReb6KCANtywPklR
        rkPRbMNQ84qxlMZDt0vyYFY773ppbeBWGKIdNI5v7m1LEVAhC3/vnj8LmRJvqCJFp4EEgs
        1oPNC8MHAAnVWrFbJYS7i1FL5V2BEug=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-ciAa8WGcN2aQ00a3-9SDKA-1; Thu, 08 Sep 2022 05:28:51 -0400
X-MC-Unique: ciAa8WGcN2aQ00a3-9SDKA-1
Received: by mail-ed1-f72.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso10992745edd.2
        for <linux-efi@vger.kernel.org>; Thu, 08 Sep 2022 02:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6pyH+1DweH0nMohfwtdsKO0eIInaeC+MrJ2yhdvIVIg=;
        b=N6W6H3K/QsX3AHGHxeoAdM3HGFZTG7PwNjY2y+qR+LXeAajyb1h27bIbMNPu7yvpaB
         R9NhR8xQv6pPUh7vGF47G7vrceh20RIUC7TLmIqzkGBvNj+OBnAYoppuFt5ZOd90+yEj
         1IZ5fnWqGwpkJAF9GATNmHD315sGJAkPm7zI4uos0oxbQiCpoY8MPC0w0sdrLJTyKHmD
         Sd2cxNWiReOAm/xNw5X4Z0cFNxlqK5ArabWVoSpxlEfbU6kRUteuUMTH4xb3KDcSx2RE
         NYIQmlm3rfgMKuHOka6IXTrfDuGJexdw4wyg4YQszXbYJEZx5+vMwRDPzJ8e+jq/qlQ8
         jRYw==
X-Gm-Message-State: ACgBeo3//vVyT0tZtlNnEP23lmQ4h23aimUl+BNQeqrmOGcHsGcUruSq
        RG/NQbXG1Q8Fv9drx3WrRRaWLkJTx1Zr9bsLqZ5dXm2tVu6ODxVyFUiMzr0nWCPgz3WeMWibKdX
        RWhSfU6TP+eBk9a0od+Xj
X-Received: by 2002:a17:906:8449:b0:73d:d822:3085 with SMTP id e9-20020a170906844900b0073dd8223085mr5369143ejy.270.1662629330602;
        Thu, 08 Sep 2022 02:28:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Wqx7dLY0r3hzFtR5IWrOsk+V2dyDrecCouKaoHpMnQxuHvZVs9kJ1VqFNaHwbksWE2d5mfQ==
X-Received: by 2002:a17:906:8449:b0:73d:d822:3085 with SMTP id e9-20020a170906844900b0073dd8223085mr5369126ejy.270.1662629330408;
        Thu, 08 Sep 2022 02:28:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id vh3-20020a170907d38300b00731582babcasm1007364ejc.71.2022.09.08.02.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 02:28:49 -0700 (PDT)
Message-ID: <fd1c459c-0c49-8fee-f71e-b2756aad84e9@redhat.com>
Date:   Thu, 8 Sep 2022 11:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 0/8] ACPI: unify _UID handling as integer
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Elie Morisse <syniurge@gmail.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Wolfram Sang <wsa@kernel.org>
References: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220907164606.65742-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 9/7/22 18:45, Andy Shevchenko wrote:
> This series is about unification on how we handle ACPI _UID when
> it's known to be an integer-in-the-string.
> 
> The idea of merging either all via ACPI tree, or (which I prefer)
> taking ACPI stuff for v6.1 while the rest may be picked up later
> on by respective maintainers separately.
> 
> Partially compile-tested (x86-64).
> 
> Andy Shevchenko (8):
>   ACPI: utils: Add acpi_dev_uid_to_integer() helper to get _UID as
>     integer
>   ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   ACPI: x86: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   i2c: amd-mp2-plat: Refactor _UID handling to use
>     acpi_dev_uid_to_integer()
>   i2c: mlxbf: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   perf: qcom_l2_pmu: Refactor _UID handling to use
>     acpi_dev_uid_to_integer()
>   spi: pxa2xx: Refactor _UID handling to use acpi_dev_uid_to_integer()
>   efi/dev-path-parser: Refactor _UID handling to use
>     acpi_dev_uid_to_integer()
> 
>  drivers/acpi/acpi_lpss.c               | 15 ++++++------
>  drivers/acpi/utils.c                   | 24 ++++++++++++++++++
>  drivers/acpi/x86/utils.c               | 14 ++++++++---
>  drivers/firmware/efi/dev-path-parser.c | 10 +++++---
>  drivers/i2c/busses/i2c-amd-mp2-plat.c  | 27 +++++++-------------
>  drivers/i2c/busses/i2c-mlxbf.c         | 19 +++++---------
>  drivers/perf/qcom_l2_pmu.c             |  7 +++---
>  drivers/spi/spi-pxa2xx.c               | 34 +++++++-------------------
>  include/acpi/acpi_bus.h                |  1 +
>  include/linux/acpi.h                   |  5 ++++
>  10 files changed, 81 insertions(+), 75 deletions(-)
> 

Thanks, patches 1-7 look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for patches 1-7.

I have one small remark for patch 8, which I will send in
a reply to patch 8.

Regards,

Hans

