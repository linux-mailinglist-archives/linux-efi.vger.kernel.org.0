Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65755AB1DE
	for <lists+linux-efi@lfdr.de>; Fri,  2 Sep 2022 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbiIBNoJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Sep 2022 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbiIBNna (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Sep 2022 09:43:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09139220D1;
        Fri,  2 Sep 2022 06:20:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e18so2682539edj.3;
        Fri, 02 Sep 2022 06:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Yflm318cdjKKS5Aq2XfV+05wBq9c0y5FzGJjH2Yk41k=;
        b=Jkbt1v21G9Rxye/+N0o+IPOTj+CuYxmmfaK+N29VNl/9G+1qxjAcFRWyz3WKpt8fpG
         0En1J4aPdQ1j2H/JkICRxNolwWhc7d9MxiK5bbehVLVvF8EGNqKn5KzTWDUAYuveOo/E
         qEa14Xcww3Atx3eBw4lCvL/p5wjoVzdVALga1VjNQPIiTEvuZDSxnwKWheAwkcKWIt3q
         lXcu6daCRI2nPoTmhpOea4xE7vXlBqojB4Q/nOhggO/jOpeLVC0vZvbxzBd6889QFMfV
         M8UmLmatw9W+2wmJl6NTPcgsrA+qmPMEJ/OHrt/x4Ot9be4MAcLFtojgME9F/vYiaUlZ
         3eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Yflm318cdjKKS5Aq2XfV+05wBq9c0y5FzGJjH2Yk41k=;
        b=jyQ5qfrsuJdSt8Y18OlpT3zSpmKo2cj0l10Dmi6XID87WCD7Lk57ZsJuXDzFJfPD8o
         pCysIfxMVMmE2/mCKIsIZe+Wx/mDESS63EN3C9rVvmUkTYFNEtKQBZQs7hvhCBk3i8D5
         n2I4xL3I/msK0sIY0XbbAKG1h05fAeTb8ml7CgiSj3vRVqPpwGJzlPgZt9+tzpMdTpn3
         cGzY30t7A2C1aQmi0H+m13JzN0WLcQPlucYeyMCPxyezgp/6MwUgneeMBGispMIDC6sE
         Ki4dH7uPNlbLFNrcw+YMPAFxkEwe+gGeJyt1iowxjspAUKFjMw7dQmQFkQf3QzfcwEmS
         rMsQ==
X-Gm-Message-State: ACgBeo0rvfVPGXba4QasNKpon0DbPKQkCQpnMrVhXH8mOwd2gZLk7myb
        dU3mfIcqC9hjJ8C2gaZU7So=
X-Google-Smtp-Source: AA6agR4OiTkdRvW0jcLpeFu+OQUHUqFNbN72o5cyjawWba6U+tMSbT/7lYfLOeesYk2FIldmbW4ZIw==
X-Received: by 2002:aa7:cb56:0:b0:447:8d82:729b with SMTP id w22-20020aa7cb56000000b004478d82729bmr33697090edt.342.1662124707233;
        Fri, 02 Sep 2022 06:18:27 -0700 (PDT)
Received: from [10.17.0.13] ([37.120.217.82])
        by smtp.gmail.com with ESMTPSA id bt14-20020a0564020a4e00b004462849aa06sm1484643edb.5.2022.09.02.06.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 06:18:26 -0700 (PDT)
Message-ID: <312ede16-f0a9-9b9e-a0d6-fb6e37d9f1bb@gmail.com>
Date:   Fri, 2 Sep 2022 15:18:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <dfd07f84-c4bd-a18c-2263-49f999f2934c@linaro.org>
 <f42539d0-c2a3-a2b2-c35b-b7a5904b376f@gmail.com>
 <db00f6a9-263d-9c47-486e-7080ffc5b3c9@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <db00f6a9-263d-9c47-486e-7080ffc5b3c9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 9/2/22 09:26, Sumit Garg wrote:
> Hi Maximilian,
> 
> On 02/08/22 18:52, Maximilian Luz wrote:

[...]

>> Thanks for this information! So as far as I understand it, this is currently an
>> interface to user-space only, i.e. does not allow in-kernel drivers for apps?
> 
> The Linux TEE framework already provides an in-kernel interface to TEE as well via TEE bus [1]. There are already multiple kernel drivers [2] [3] [4] [5] [6] [7] using it. So an EFI driver can be an addition to that.
> 
> Now coming on to TEE implementations, the drivers I mentioned are based on OP-TEE where devices are queried/enumerated during OP-TEE probe here [8]. So in similar manner QTEE smcinvoke driver should be able to register devices on the TEE bus.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/staging/tee.rst#n56
> 
> [2] drivers/char/tpm/tpm_ftpm_tee.c
> 
> [3] drivers/char/hw_random/optee-rng.c
> 
> [4] drivers/firmware/arm_scmi/optee.c
> 
> [5] security/keys/trusted-keys/trusted_tee.c
> 
> [6] drivers/firmware/broadcom/tee_bnxt_fw.c
> 
> [7] drivers/rtc/rtc-optee.c
> 
> [8] drivers/tee/optee/device.c

Thanks for those links!

I think it would indeed be good if we could make it work via that
interface and I guess that should generally be possible. As far as I can
see, the biggest problem might be that the current firmware doesn't seem
to use UUIDs, so I guess we might need to emulate them somehow.

It would be great if someone with some actual knowledge of the firmware
used on those devices could have a look at this and provide some
insights.

My plan for now is to hold off on the UEFI variable driver until we have
a (proper) TEE driver, which unfortunately might be a bit out of my
depth. I'm happy to help out in any way I can though.

Regards,
Max
