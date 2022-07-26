Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32C4581808
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 19:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiGZRBd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 13:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiGZRBc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 13:01:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCF42A411;
        Tue, 26 Jul 2022 10:01:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b11so27227982eju.10;
        Tue, 26 Jul 2022 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NbaTapVTjMuA8ZsqkyiWb1fIAjT6txQZhbh0GKz3IA4=;
        b=VnVDHcXsW+0Sq6u9pAephU5mG5MRWuSSMurKkVzEhqGpxhbqkcxn4RX5CjYbgtlkgJ
         M3LAb15RQpPWO8g/X0cgPUK79Ma60vU+Jy7N1H6539UgeK8jXWzP+vM7w+RV7oRYdSwo
         KaS/ERr+QNuWRN7zH4zEKDpPlaTkRYK192/PWbA4Y6NlSnl/7yrFvZx3tYAqSIbIOpab
         WkTiIv3+y0CpJGLE6rIkEN1DX+8j5/R3G7tNwkQXJ9GnRfq6D+xTvAJs53KKKcV7Ui7n
         b1xcC0MKOFf8CpQ3HSok2ASM7iNUvh4DB0qZpAiWt03qIghViz1UxmzmIFsbpYOY9XpV
         0+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NbaTapVTjMuA8ZsqkyiWb1fIAjT6txQZhbh0GKz3IA4=;
        b=xnHDcStvwmnfLuzbZuFLIal40gcw6wz7e/BEJJorRHN80SEj4aH8G6/jK3xONxmBDn
         Q7hCOw4tq/76Z5cFrlCOd7zwVKUV9lNt3B8makryHS8TrAwcuxIVfSHyK0NGk6Qt0UwE
         ITRowmlcuv3tLXuZt7SfDGeMrwGj6p/2KmV92NoZHcwu/8yxu3n2PIdnGMil85CFTlU5
         d0vaZAfFdtFEtbW6xOAKWYtN4d3aSeBUTq5xDfTBYbPCOscKLJWULoRqItBd/YneM6Id
         7fwr5Uk3qno2dckk1fyLux3hB3Gv0ou7sEhNRYJapfKQ/pWFsqXLbmcjTXCaivwOr1pm
         6uqg==
X-Gm-Message-State: AJIora/9DSQ+diIZxV/U8/5+ILTh0dL/pzTTTapFwhuNYewOzsXSpQeW
        6bdBVbPx1NQuUsKjhpR+ja0=
X-Google-Smtp-Source: AGRyM1tEjs1he/rHOn57YR8o1o0mWk9Ro4ZDRiecQ5FNAoLp/ufCywc5e5heR4goX/8r02WID9bSEg==
X-Received: by 2002:a17:906:cc0e:b0:72b:311b:8ed9 with SMTP id ml14-20020a170906cc0e00b0072b311b8ed9mr15002494ejb.186.1658854889674;
        Tue, 26 Jul 2022 10:01:29 -0700 (PDT)
Received: from [10.30.0.4] ([37.120.217.82])
        by smtp.gmail.com with ESMTPSA id d18-20020a170906305200b006feba31171bsm6670821ejd.11.2022.07.26.10.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:01:29 -0700 (PDT)
Message-ID: <d1bc99bb-82ce-aa6e-7fad-e9309fa1c19b@gmail.com>
Date:   Tue, 26 Jul 2022 19:01:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220726154138.74avqs6iqlzqpzjk@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 7/26/22 17:41, Sudeep Holla wrote:
> On Tue, Jul 26, 2022 at 05:15:41PM +0200, Maximilian Luz wrote:
>>
>> So ultimately I think it's better to add a DT entry for it.
> 
> I disagree for the reason that once you discover more apps running on the
> secure side, you want to add more entries and update DT on the platform
> every time you discover some new firmware entity and you wish to interact
> with it from the non-secure side.

Just as you'll have to add a driver to the kernel and update whatever is
probing the TrEE interface and add those strings to that interface. If
you then start doing SoC-specific lists, I think you'd be pretty much
re-implementing a DT in the kernel driver...

I don't quite understand why this is a problem. I think per device,
there's a reasonably limited set of apps that we would want to interact
with from the kernel. And for one single device, that set doesn't change
over time. So what's the difference to, say, an I2C device?

> As along as get this application ID can handle any random name, I prefer
> to use that as the discover mechanism and not have this DT.

Apart from the above, some apps must also be loaded from the system. And
those you can't detect: If an app isn't running, it doesn't have an ID
(uefisecapp and the tpm app are loaded by the firmware at boot). Those
are mostly vendor-specific things as far as I can tell, or HDCP stuff.
So you'd need to specify those as firmware somehow, and since (as far as
I can tell) those are signed specifically by/for that vendor and
potentially device (similar to the GPU zap shader or remoteproc
firmware), you'll need to use per-device paths.

That means you either hard-code them in the driver and have a compatible
per model, do DMI matching, or something similar (again, essentially
baking DTs into the kernel driver...), or just store them in the DT
(like we already do for GPU/remoteprocs). While you could hard-code some
known loaded-by-firmware apps and use the DT for others, I think we
should keep everything in the same place.

Windows uses a hard-coded list of supported apps in the driver (to
specify which apps the driver supports) and in addition to that uses
Registry entries (added via .inf files) to specify which app is supposed
to be present on the device and, for apps that need to be loaded, where
the firmware to be loaded is stored. It only ever attempts to connect to
those apps that are marked present in the registry. Which, again, may be
model/vendor specific.

And this is another reason I'm hesitant to use that function: Windows
doesn't use it in this way and that I don't know whether there can be
any subtle breakage or unexpected behavior if we use the function like
that (i.e., who's to say some broken firmware returns "app is present"
but the app is broken?).

Regards,
Max
