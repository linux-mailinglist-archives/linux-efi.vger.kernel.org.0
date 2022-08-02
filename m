Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8174588253
	for <lists+linux-efi@lfdr.de>; Tue,  2 Aug 2022 21:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiHBTL7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 2 Aug 2022 15:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHBTL7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 2 Aug 2022 15:11:59 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7B52702;
        Tue,  2 Aug 2022 12:11:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z4so1983282ljn.8;
        Tue, 02 Aug 2022 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3bvHSL4jo5dqmiw6tjFQyqXjPqhxqKwJwmPSxxlR63Y=;
        b=n3xEZzogiOs9ZwIgZxS2PSvnYU8m93jcAA9Sm2MAfCMwyEa35AS53DTZh0l3pwvzXL
         FS/ChfExwS72nql3OcJZKCCHpA13xG0YGv/5lvH9GRu+PaSFX2dR/VX3Epo66CnLin44
         ODrXSOtwbW36ubjO10FLiAu0v7nBIBYjN1GDRkKjxzwlTI45dAk/urS1IKgV4pfJlUJB
         CsHDzzo4m7TlyAcJhd5zYkF9C0eXS5RnhLKQ+OZV9XzDdyuA4tJr6mzh4RWxR5Ha6Jai
         eBRY1dHWUcDHKTkWVdMQ7+aabOXavjPcXzqfSQ4Kbjbwy4Sb2r5nJ4iXtH54AeCr4NOg
         hl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3bvHSL4jo5dqmiw6tjFQyqXjPqhxqKwJwmPSxxlR63Y=;
        b=jkXn5IHnXgnjdOAe3RrGaaAaayUXNSyz6vN3jUldhoeM3jLWDhCKRojkCcPmgGQdev
         LfU3Hq+6D7VgCLLcgUCMZ7vC1deOFvbCgLKk3wQufEGLdTdKpyfeLS0VrSULCfxiV3PY
         2QNa1lsbU5Q82/odgBy0CdCrzwv5WX2LrQP1Ng1abjZdckhgDqPL7IxnbkpRVnrk8Ljb
         a/PDOxPLE/VHb5hliczfCBKiWTE5GqtgzSUn/FNrvDFNVN+bLVOjqkfoH1jhM16GyhmM
         TOXzxJKl842NPEJhCrZTzMmBUZyMHbmpBvbG8yZuAbB5cgDYOW+TiqPG9O6WkBYob3V8
         9ntA==
X-Gm-Message-State: AJIora93TAwuV/gOr/WojZ9/G1aPRPDtcw/TLwWYs3CAH2qIj4b/ojOk
        ImErczNGL982UEjHBRxv29lIhDLEcX8=
X-Google-Smtp-Source: AGRyM1u4tykpqMSfoWQWoqLsc9E2xJBK3ESSCihNTwIwfMG7YHRR0VcIT4XVJfzxYitbVvx9ccbYXQ==
X-Received: by 2002:a2e:be22:0:b0:25e:26e8:fd2f with SMTP id z34-20020a2ebe22000000b0025e26e8fd2fmr6894524ljq.443.1659467511952;
        Tue, 02 Aug 2022 12:11:51 -0700 (PDT)
Received: from [192.168.2.202] (pd9ea344f.dip0.t-ipconnect.de. [217.234.52.79])
        by smtp.gmail.com with ESMTPSA id h14-20020a05651c124e00b0025e6415bb8csm203653ljh.32.2022.08.02.12.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 12:11:51 -0700 (PDT)
Message-ID: <ce805c48-3772-159b-4b82-d0875b52c144@gmail.com>
Date:   Tue, 2 Aug 2022 21:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <dfd07f84-c4bd-a18c-2263-49f999f2934c@linaro.org>
 <f42539d0-c2a3-a2b2-c35b-b7a5904b376f@gmail.com>
 <CAMj1kXExyKKHK0A48vmqxqRHrT+xgDt3qB1gHvJ31gPAeE2KSA@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAMj1kXExyKKHK0A48vmqxqRHrT+xgDt3qB1gHvJ31gPAeE2KSA@mail.gmail.com>
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

On 8/2/22 16:02, Ard Biesheuvel wrote:
> On Tue, 2 Aug 2022 at 15:22, Maximilian Luz <luzmaximilian@gmail.com> wrote:

[...]

>> I generally agree with the sentiment, however UEFI variables should IMHO be
>> handled by the kernel. Moving handling of those to userspace breaks things like
>> EFI-based pstore and efivarfs. The latter will in turn break some user-space
>> tools (most notably efibootmgr used by e.g. GRUB and I think fwupdmgr which
>> needs to set some capsule variables). Ideally, we would find a way to not break
>> these, i.e. have them work out-of-the-box.
>>
> 
> Only capsule-on-disk requires SetVariable() at runtime, and I doubt
> whether these platforms implement any of that.
> 
>> A similar argumentation might apply to the TPM app.
>>
> 
> There is a difference, though - the TPM is modeled as a device and
> runtime access to it is implemented as a device driver, which is only
> accessed from user space.

Ah, thanks for that info! I wasn't sure about that last part.

But we'd still need _something_ in the kernel. All the common software
using TPMs would expect the TPM to be present as /dev/tpmX. So, while it
doesn't have to be a full secure-app driver, we'd need at least some way
to manage a TPM device from user-space (unless we want to tell all
software using TPMs to just support some non-standard thing instead).

For EFI variables, something similar might be possible (i.e. running
efivar operations through a user-space driver), but that will break
pstore in the times it's most usable (i.e. when no user-space exists or
things are sufficiently broken that we can't run things through it any
more).

And then (at least for me) there's the question whether that all seems
sound: Sure, we can maintain some userspace-daemon outside the kernel,
but if it is common enough (i.e. not a one-off used only by some single
vendor and model) and can be easily implemented in the kernel, why not?
Moving it to userspace makes things more complex. You'll need new
userspace APIs (as mentioned above, if you don't want to force all
existing software to adapt to some non-standard thing) and you need to
tell users to install and set up some daemon(s) (making it yet more
difficult to produce a single proper install media that works well on
all the common AArch64 or WoA platforms). All the while you still need
to maintain essentially the same piece of code (whether it is inside or
outside of the kernel), so you don't really win anything there either.

Regards,
Max
