Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8DB5B18AC
	for <lists+linux-efi@lfdr.de>; Thu,  8 Sep 2022 11:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiIHJ3b (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Sep 2022 05:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiIHJ33 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Sep 2022 05:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4B82661
        for <linux-efi@vger.kernel.org>; Thu,  8 Sep 2022 02:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662629366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=casXnlyfem/cMcq/zKr8AiPcnoA42iZlvAPreQZv3fs=;
        b=JE6aFMG1aV9VXMjrV/a9c1NjPGbjTt6NjNbdXoHQ40f6AlmLddY4oGb2gs6IW9OAtn+QdF
        iWhNyYGd3YS2Zo8DRIA2owZ77ghlSWrgJSM8aT9/ttGBiEPtZYtOLoLwTyOBAWs1UEHCxL
        IqBiaxz7CwflIXygj8QFL+VuNvA6xH8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-66-7SrVmXAZPfePd07BRhmP9g-1; Thu, 08 Sep 2022 05:29:25 -0400
X-MC-Unique: 7SrVmXAZPfePd07BRhmP9g-1
Received: by mail-ed1-f71.google.com with SMTP id z9-20020a05640235c900b0044f0575e9ddso3053941edc.1
        for <linux-efi@vger.kernel.org>; Thu, 08 Sep 2022 02:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=casXnlyfem/cMcq/zKr8AiPcnoA42iZlvAPreQZv3fs=;
        b=CleWGrHgNg+pEWhhk9ah6ca+hiu4gg6m4Dk3j7msUmdCM8Guo3hTRZF96TLy7rLRUD
         +irTILIeUANiuEo6oQUexkPthb60877T6ij1HIYABiqGm36c/ATQdJn+4mWv6NAGn+Oq
         hQD1txW9K0hKiitY9gQdXkdsf/E+WNLi4nC95HcPduNqfu2EANaip2yHFxSgpelKk4BU
         UuouAGM5naMWnnQtjapBzu8s3aF50Etwgiw/54uuCFzP1lsEYacrZhS1+o+3j4r15z1P
         b947cWtJZSAOT37CiCi9A+cHmjXFugsoSgZT9KCVYNNkksgs/AiLr+sl+Y6Offv32EqQ
         7ynA==
X-Gm-Message-State: ACgBeo1mFgJSbQ861gsN3ID/vbV8CqZutaX6voV+059f8Q+SG/X0H/H+
        pd2UjdKX2qcFOnPPK9OGlPHGL+8IlDTe/bKYBVxx1hmrq9KFXAeausqyh+ZDeC3RQ6UocX1IHgn
        IkXHutDIIysPrT7NmD2v4
X-Received: by 2002:a05:6402:e96:b0:443:a086:e3e8 with SMTP id h22-20020a0564020e9600b00443a086e3e8mr6635002eda.330.1662629364653;
        Thu, 08 Sep 2022 02:29:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7dC5R82XPS91l4CxPlXPGCcS/hi02/tOGJdVWXrPtNkFqqjr46QX0/6Sg6lODyX2MG2aj1BQ==
X-Received: by 2002:a05:6402:e96:b0:443:a086:e3e8 with SMTP id h22-20020a0564020e9600b00443a086e3e8mr6634970eda.330.1662629364485;
        Thu, 08 Sep 2022 02:29:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id w6-20020a50c446000000b004476c19d126sm12139269edf.38.2022.09.08.02.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 02:29:23 -0700 (PDT)
Message-ID: <72acff59-81f0-f466-6197-d3e993f051ac@redhat.com>
Date:   Thu, 8 Sep 2022 11:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 8/8] efi/dev-path-parser: Refactor _UID handling to use
 acpi_dev_uid_to_integer()
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
 <20220907164606.65742-9-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220907164606.65742-9-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 9/7/22 18:46, Andy Shevchenko wrote:
> ACPI utils provide acpi_dev_uid_to_integer() helper to extract _UID as
> an integer. Use it instead of custom approach.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/firmware/efi/dev-path-parser.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
> index eb9c65f97841..113b3ca1bd76 100644
> --- a/drivers/firmware/efi/dev-path-parser.c
> +++ b/drivers/firmware/efi/dev-path-parser.c
> @@ -15,9 +15,11 @@
>  static long __init parse_acpi_path(const struct efi_dev_path *node,
>  				   struct device *parent, struct device **child)
>  {
> -	char hid[ACPI_ID_LEN], uid[11]; /* UINT_MAX + null byte */
>  	struct acpi_device *adev;
>  	struct device *phys_dev;
> +	char hid[ACPI_ID_LEN];
> +	long ret;

"long ret" should be "int ret" here since that is what acpi_dev_uid_to_integer()
returns.

Regards,

Hans


> +	u64 uid;
>  
>  	if (node->header.length != 12)
>  		return -EINVAL;
> @@ -27,12 +29,12 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
>  		'A' + ((node->acpi.hid >>  5) & 0x1f) - 1,
>  		'A' + ((node->acpi.hid >>  0) & 0x1f) - 1,
>  			node->acpi.hid >> 16);
> -	sprintf(uid, "%u", node->acpi.uid);
>  
>  	for_each_acpi_dev_match(adev, hid, NULL, -1) {
> -		if (adev->pnp.unique_id && !strcmp(adev->pnp.unique_id, uid))
> +		ret = acpi_dev_uid_to_integer(adev, &uid);
> +		if (ret == -ENODATA && node->acpi.uid == 0)
>  			break;
> -		if (!adev->pnp.unique_id && node->acpi.uid == 0)
> +		if (ret == 0 && node->acpi.uid == uid)
>  			break;
>  	}
>  	if (!adev)

