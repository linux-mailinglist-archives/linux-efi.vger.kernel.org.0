Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A18A66DD31
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 13:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbjAQMHb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 07:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbjAQMH2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 07:07:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A332E62;
        Tue, 17 Jan 2023 04:07:27 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q10so11025242wrs.2;
        Tue, 17 Jan 2023 04:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jhCLOl1gfiDWYLG658j5YBz8FjzZRtMl97FC6ilH1Nw=;
        b=PJ+D+G9LpqeM6ga1PYu23XZneM4IMlbtCEIYrVA01TB1CIRNGc52EQjxxqDWaCJrNA
         bgcDFoRoR7zKp33uoe5OnCysLDlVJkUwx7MuTeSjryADkqK3nYmvn7N5yEO/wmS/K64s
         kTkFkrlwdBz2CZnLo/o68ZVf8gch+h7LhPH7XsnurOih2RiOFYZ5OubvcCAR4UZLitu7
         7yJdzuZpz0SgJG3T4OJqEvJEOx8DAnryoFtniiOtwvlrWr9WM2bnjC2jk+h7v2DjeoA2
         Py5TVdwJ6nOoNdPs9XSnQBB4L3SABREU+Fnf8je/5O07MLp6lPNj+709DroVzsiUxINE
         5aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhCLOl1gfiDWYLG658j5YBz8FjzZRtMl97FC6ilH1Nw=;
        b=mAyD6GsP/QyuTkj+bQrCjinwijWiq4elGvItG6YofjXTXrd6RqEj5eqwRFhymzx973
         Tklr+YVDVDSOZw9YeGvcQvEmSmN7XQtQmSme7+gm8LiqMWKwmXcXSJeou4gXikxzLyOn
         Lhpf51QiRrF6nOWAJGMXTZN27TlOnJvickyezC1as0+vIAPrfM2MQXE4WQPhDUPlZhpV
         BqsUADMNZfMd5uG+QnVdLSTcQGH0ZUHDqGNU2n9mV1zFZ2IB4/zjC0gRWRoE0zPzRBHk
         Ai5NmjmEvuYmR+mCd9mIP/rn7UCQpge9mN4mQtw+sRUlaKkL8NXjd2tZ9RUjPvgB0ciD
         sR1A==
X-Gm-Message-State: AFqh2kqGOjZysixX4gmxVHLyypEJpuuULasCXI+p+HkOHMErDqokUJgM
        NxDV5BkCsT/iKFEi5S+3704=
X-Google-Smtp-Source: AMrXdXuJ2kqxZTRI6HJoyYnGfT9iM5c87NwN1/XerjU9jQuqsJSQLSV7n9ouA3ykGTHudsvfUVtEBg==
X-Received: by 2002:a5d:6f03:0:b0:2bb:e896:5a09 with SMTP id ay3-20020a5d6f03000000b002bbe8965a09mr3037185wrb.66.1673957245833;
        Tue, 17 Jan 2023 04:07:25 -0800 (PST)
Received: from [192.168.2.202] (pd9ea3141.dip0.t-ipconnect.de. [217.234.49.65])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600018ab00b002be2279f100sm1394355wri.96.2023.01.17.04.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 04:07:25 -0800 (PST)
Message-ID: <66f076ae-a9b5-f595-a88d-ede66a7e8e89@gmail.com>
Date:   Tue, 17 Jan 2023 13:07:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] firmware: Add support for Qualcomm UEFI Secure
 Application
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-4-luzmaximilian@gmail.com>
 <Y8aA60iJ0Sv2IrLm@hovoldconsulting.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <Y8aA60iJ0Sv2IrLm@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/17/23 12:05, Johan Hovold wrote:
> On Sun, Jul 24, 2022 at 12:49:48AM +0200, Maximilian Luz wrote:
>> On platforms using the Qualcomm UEFI Secure Application (uefisecapp),
>> EFI variables cannot be accessed via the standard interface in EFI
>> runtime mode. The respective functions return EFI_UNSUPPORTED. On these
>> platforms, we instead need to talk to uefisecapp. This commit provides
>> support for this and registers the respective efivars operations to
>> access EFI variables from the kernel.
>>
>> Communication with uefisecapp follows the standard Qualcomm Trusted
>> Environment (TEE or TrEE) / Secure OS conventions via the respective SCM
>> call interface. This is also the reason why variable access works
>> normally while boot services are active. During this time, said SCM
>> interface is managed by the boot services. When calling
>> ExitBootServices(), the ownership is transferred to the kernel.
>> Therefore, UEFI must not use that interface itself (as multiple parties
>> accessing this interface at the same time may lead to complications) and
>> cannot access variables for us.
>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>> ---
> 
>> +static int qcom_uefisecapp_probe(struct platform_device *pdev)
>> +{
>> +	struct qcuefi_client *qcuefi;
>> +	int status;
> 
> [...]
> 
>> +	/* Set up kobject for efivars interface. */
>> +	qcuefi->kobj = kobject_create_and_add("qcom_tee_uefisecapp", firmware_kobj);
>> +	if (!qcuefi->kobj) {
>> +		status = -ENOMEM;
>> +		goto err_kobj;
> 
> When preparing some related EFI patches, I noticed that the error labels
> here are named after where you jump from rather than after what they do
> (as is suggested by the coding standard).
> 
> Would you mind changing that (throughout) for your v2?

Not at all. Will change that for v2.

Regards,
Max

>> +	}
>> +
>> +	/* Register global reference. */
>> +	platform_set_drvdata(pdev, qcuefi);
>> +	status = qcuefi_set_reference(qcuefi);
>> +	if (status)
>> +		goto err_ref;
>> +
>> +	/* Register efivar ops. */
>> +	status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops, qcuefi->kobj);
>> +	if (status)
>> +		goto err_register;
>> +
>> +	return 0;
>> +
>> +err_register:
>> +	qcuefi_set_reference(NULL);
>> +err_ref:
>> +	kobject_put(qcuefi->kobj);
>> +err_kobj:
>> +	qctee_dma_free(qcuefi->dev, &qcuefi->dma);
>> +	return status;
>> +}
> 
> Johan
