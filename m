Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F3583E69
	for <lists+linux-efi@lfdr.de>; Thu, 28 Jul 2022 14:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbiG1MOJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Jul 2022 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbiG1MOI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Jul 2022 08:14:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30FD6A4A2;
        Thu, 28 Jul 2022 05:14:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id va17so2938655ejb.0;
        Thu, 28 Jul 2022 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=scVy0siNZQpTUdZNL0fbzg1tkYynfpBNYNosy5mDXbo=;
        b=L1d+CZwzgEYbBQfAzHvwLizC1GGkZ90spMFq1QdruzSr63GvGl1AcEs22RojeLnbsG
         PXacIVMpW+xbG7m1aDuXWx3QO/0tbRAQ/apH+gzBDFpkrBobX4y4KnaUeV90QOk4HXAb
         0eR4gOqBUTJvjQJfXZ/cwIo8U5l6/qp9TMyTgY4agh4epz+MweVcz0KHTkuGQV7EQmPQ
         y5dTNk4+HBISwbw40woua8pheq+Lyk5TiP+07wcj6WEIjypXwcI9fefz0LaPjuY9Ks9G
         AU+3hIpK0jhvaL+A7oYFWyDtqlnCkxhbZ2+/7RTU0MAD3ak3jAhpFqAXO5gKgTujzus7
         R9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=scVy0siNZQpTUdZNL0fbzg1tkYynfpBNYNosy5mDXbo=;
        b=M4xtLAocg/NyfP6Gdhe54Y1d0C2bfOIBKB2t5HWNt3AD+PhSXLUK/CKpjPWmorInLM
         gommY+E92jeySVuWjqc7p3rzGQO281+n4C5iKgJTK7qXl5RLyArK+fSPYhR7k2b3e7iX
         cUl3dFpqXfKKjQTD+HnT8XvBFFccDlOPQSTkWjZla0U7CgwCXl8lzzM/9zy8HZBNG8I0
         +gjo0iEYMYhx8LlkpgxLgUbXxusiuZJXGXVFG4IGhvvHU337ar4yyoohc8d+Dgnl8D+e
         SDARMnLxc0rK3UIt7DoDWgkIBHdSYMahrhpe/68SJVSI8SqylEBJsB2YOS21khOsf8un
         WX6w==
X-Gm-Message-State: AJIora8pKzJo9NOsz4/v4Joe1TUmOOu1g+SND0+1lwDSaiz+t4QkzSnV
        OKoamgNe6DnOczED6Zd6GyU=
X-Google-Smtp-Source: AGRyM1v8wI8e/9YVypkA6YmuF9VMTC2v748xvT/qo96rRnB5rK/71JOzO0432SDZmmnY/cQxLEN2Jg==
X-Received: by 2002:a17:907:2bf4:b0:72b:3336:ca9e with SMTP id gv52-20020a1709072bf400b0072b3336ca9emr20838356ejc.341.1659010445268;
        Thu, 28 Jul 2022 05:14:05 -0700 (PDT)
Received: from [10.31.0.4] ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b006fee98045cdsm367373ejf.10.2022.07.28.05.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 05:14:04 -0700 (PDT)
Message-ID: <e9c6e5dd-928c-c227-eb03-708e6b3e1a26@gmail.com>
Date:   Thu, 28 Jul 2022 14:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
 <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
 <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com>
 <20220727132437.pjob3z2nyxsuxgam@bogus>
 <CAC_iWj+Pn+h8k=fuDHzYwqD0g4m6jGRt8sCzcz+5+rYqvz9q4w@mail.gmail.com>
 <fd922f0f-99fd-55a3-a0b5-b62ad2dbfb45@gmail.com>
 <20220728113347.ver6argevzmlsc2c@bogus>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220728113347.ver6argevzmlsc2c@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/28/22 13:33, Sudeep Holla wrote:
> On Thu, Jul 28, 2022 at 12:48:19PM +0200, Maximilian Luz wrote:
> 
> [...]
> 
>>
>> I would very much like to avoid the need for special bootloaders. The
>> devices we're talking about are WoA devices, meaning they _should_
>> ideally boot just fine with EFI and ACPI.
>>
> 
> Completely agreed.
> 
>>  From an end-user perspective, it's annoying enough that we'll have to
>> stick with DTs for the time being due to the use of PEPs in ACPI.
> 
> But have we explored or investigated what it takes to rewrite ACPI f/w
> to just use standard methods ? Does it require more firmware changes or
> new firmware entities or impossible at any cost ?

Again, I'm not a Qualcomm employee. I would prefer it they'd use
standard methods in the future. Rewriting the ACPI tables based on the
information that we have is probably possible, but we'd again have to do
this on a device-by-device basis, so why not just write a DT instead?

Again, I'm not a Qualcomm employee. I would prefer it they'd use
standard methods in the future. I cannot say why they are using PEPs and
whether they can't just use something "normal". Rewriting the ACPI
tables based on the information that we have is probably possible, but
we'd again have to do this manually, on a device-by-device basis. So why
not just write a DT instead?

Apart from that they also unfortunately hard-code a lot of SoC specific
MMIO addresses into their drivers, so, for each SoC, they essentially
have their own ACPI HID even if the specific hardware interface hasn't
changed. It's bad all around... and I don't like it one bit either.

> For me that is more important than just getting this one on DT. Because
> if you take that path, we will have to keep doing that, with loads of
> unnecessary drivers if they are not shared with any other SoC with DT
> support upstream. We might also miss chance to get things added to the ACPI
> spec as we don't care which means that we never be able to use ACPI on
> similar future platforms even though they get shipped with ACPI.
> 
> It will be a loop where we constantly keep converting this ACPI shipped
> platform into DT upstream. IMHO we don't want to be there.

I fully agree with that. And that is also something that I fear.

Unfortunately, the only way out that I can see is either Qualcomm
changing its ways or us supporting ACPI PEPs, doing hard-coded register
addresses based on ACPI HIDs, and converting a lot of existing drivers
written for DT/OF to support ACPI. I personally would prefer if we'd do
all that and hope that we can one day support PEPs.

Once we do, we'd at least "only" have to add the needed MMIO definitions
for drivers via HID matches and write a PEP driver for that specific SoC
(which would then be similar to regulator or clock controllers). Still
some work but a lot less than having to write DTs for each and every
possible model.

As much as I'd like to support and work on that, I'm doing this in my
free time, and this sounds like a big undertaking. At the moment, my
efforts are focused on making the Surface Pro X play (relatively) nice
with Linux (via DT). I had thought about this, but my time to work on
this is unfortunately limited. You'd probably have to ask e.g. the
Linaro folks for help and input (some of which, e.g. Bjorn Andersson
are currently working on DTs for WoA devices), and also convince the
ACPI maintainers.

Regards,
Max
