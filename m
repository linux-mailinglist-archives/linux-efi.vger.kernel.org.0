Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B24D582752
	for <lists+linux-efi@lfdr.de>; Wed, 27 Jul 2022 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiG0NDy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Jul 2022 09:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiG0NDy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Jul 2022 09:03:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4370526AD3;
        Wed, 27 Jul 2022 06:03:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c22so10460241wmr.2;
        Wed, 27 Jul 2022 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SiHZwpQCYfccD1xnABRjwBNsvXyqatith9sO/0ewvoY=;
        b=GjHqFnyWpHKA/Jz+vu/FGWShm0+Mz6AW0SDGdFOI7AGOATGcBG61VAAYmAXfpM/5S8
         zfaZCUthDWABPLd8yycyiWxUqFAAqSBBqVn5Ozz5FuaN2UotHuwEzJXSL2iAFcvxjwfU
         R5qKl757CyZrfHjDMQXWWAue7iTSIkURZEVM6+kAyZtHTPiKwAIa+/LcjzwcDJgKvdx9
         MEOEAf6qCqwrwwq3pTOR6r3++yYrUikZo96LGMRvVdtWd10bYBlqTkn5kejJpU/sJoev
         MF2nPCuTGq7pPvhc8sTgTEKaZyZPFHJXm2VR/ct5DlQtv6nGqiqqWR3FtMeHK30XoGG9
         wS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SiHZwpQCYfccD1xnABRjwBNsvXyqatith9sO/0ewvoY=;
        b=r+sA8f7XYfnddis4dFsZEd4oRk7ZCokEVV/xo2MG/CfnH8KL/NgObuR1dO8ZIfVUgR
         aW6r8y9fyDgX1xhM77BFSdF9E5GyfwjiLju+S0DVbGLvwzaphLA53gBZpywFi/uLUXKg
         KPyI1bBTG/94a6UJmtfv6Y53mWakz4qeNsdmT1KqJiHl5Hx8YSIhGViLiD6f2+qvW0rZ
         Mj9e+vIjPQh+PHd++pTikNxhdTNIuCIZ3nbHeSaJKD2CHT2awQ6CpQoE/lUDd+R4IXJg
         yUyVcmRBd9Gbz5+o6vCDbIVgOmeXAwfh4VAky6KTv6n5Y9mmHntUMAURNyk5VzZiDT87
         2x5A==
X-Gm-Message-State: AJIora8UbjXXD9TsvZ+rGIFwP1RkGBclkpcWL7suuzzPzMwkkMCMLmyT
        Bkawsuvp6xpWs8I6ur4M85w=
X-Google-Smtp-Source: AGRyM1tJyqDtyv+DYGgsu8rV4ce7hW8Up+s8gxPMO1orqS/QB3LEo2yn97xQ+7FJzlw3XtUWOzvjYw==
X-Received: by 2002:a05:600c:3586:b0:3a3:2c03:1088 with SMTP id p6-20020a05600c358600b003a32c031088mr3207007wmq.64.1658927031617;
        Wed, 27 Jul 2022 06:03:51 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea3316.dip0.t-ipconnect.de. [217.234.51.22])
        by smtp.gmail.com with ESMTPSA id f23-20020a1cc917000000b003a31ca9dfb6sm2684519wmb.32.2022.07.27.06.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 06:03:51 -0700 (PDT)
Message-ID: <3d752603-365d-3a33-e13e-ca241cee9a11@gmail.com>
Date:   Wed, 27 Jul 2022 15:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Andy Gross <agross@kernel.org>,
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
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <20220726143005.wt4be7yo7sbd3xut@bogus>
 <829c8fee-cae5-597d-933d-784b4b57bd73@gmail.com>
 <20220726154138.74avqs6iqlzqpzjk@bogus>
 <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
 <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <7284953b-52bb-37ac-fbe1-1fa845c44ff9@linaro.org>
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

On 7/27/22 13:38, Krzysztof Kozlowski wrote:
> On 26/07/2022 19:01, Maximilian Luz wrote:
>> On 7/26/22 17:41, Sudeep Holla wrote:
>>> On Tue, Jul 26, 2022 at 05:15:41PM +0200, Maximilian Luz wrote:
>>>>
>>>> So ultimately I think it's better to add a DT entry for it.
>>>
>>> I disagree for the reason that once you discover more apps running on the
>>> secure side, you want to add more entries and update DT on the platform
>>> every time you discover some new firmware entity and you wish to interact
>>> with it from the non-secure side.
>>
>> Just as you'll have to add a driver to the kernel and update whatever is
>> probing the TrEE interface and add those strings to that interface. If
>> you then start doing SoC-specific lists, I think you'd be pretty much
>> re-implementing a DT in the kernel driver...
> 
> But you don't have any of these names in the DT either. Your DT node
> only indicates the presence of your driver, but does not hold any
> additional information like these IDs.

Because the compatible implicates the ID-string which implicates the driver
interface. If the ID-string for uefisecapp would be different we'd very likely
need a different driver for that as well, meaning a new compatible too. I
thought it would be superfluous to put that in the DT.
  
> Basically we start modelling firmware components in devicetree. :/

Is there really a good way around it? As far as I can see the
alternative (especially for the apps that need to be loaded manually) is
hard-coding everything in the driver. Which IMHO just spreads device
specific information everywhere.

Also: Let's use the TPM app as example. If that would be a SPI or I2C
device, you'd model it in the DT. Just because it's a hardware device
that's accessible via SCM/firmware you now don't?

If I were absolutely certain that there is a reliable mechanism to
detect these apps, I'd agree with having a driver to instantiate those
devices. But I am not.

Regards,
Max
