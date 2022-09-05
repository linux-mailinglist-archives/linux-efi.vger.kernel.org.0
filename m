Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B1D5ACB65
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 08:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiIEGvG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 02:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiIEGvF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 02:51:05 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F610192AC
        for <linux-efi@vger.kernel.org>; Sun,  4 Sep 2022 23:51:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z29so11706523lfb.13
        for <linux-efi@vger.kernel.org>; Sun, 04 Sep 2022 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7l1Ke7T6M+oZvtuxdITH0Qf+JbsLNo5gUL5ZqA0qy+Y=;
        b=oV31RxlKuOTqexYDOvpxYXg7TBDxHrnLEFY+R1VNIIdDPLKabg29Ons+XPT4mT7Crm
         wxifLo8pLdwG7KsbbWfpvKm5gJrIMjcVPyDEoWM7M0aUPB4VM05NUwhdRFi1zb/v7owO
         QvgXv7bsSjDZpmpq18+gY4kFIEW66Y70dA/4pvTky7pdsi1J9tbNEUDAYzPkJjpqd0BO
         Kw0kxz6u9Epjq8pryosYXKIqXVJAM5UAYWYUuRWdvfHiy7PwMGXbWHnVLKr2mwDW7oqX
         Et1jbwLYKYbw3qP0jd+zVPG80Yq8JVdqG3URN5to74xfxFKDcDZFZpnh7sZjYvlLWQSa
         +vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7l1Ke7T6M+oZvtuxdITH0Qf+JbsLNo5gUL5ZqA0qy+Y=;
        b=RV413L3kwphnbIg/t2Sa4YaQaKbfHSb4ffe9HpXlE5MM3hbGHvGYXetZxHpMO9juGe
         T7GOE9LE3BNUagy2xEoOnKMMkFP5uhXL7QEd5KAw8CGQDY93ymh+ugwb3tp4fX7BEwD0
         +WPMztzIDWewsdUhJ32jMo47oAAdoVDG7eDSV4R9aJ1fQxZmTWWxtLeMFWhIdQXhDt43
         NLwpnUudJ0or6XNXjDt///vVrb+Kmq7fHEgT88Z85fkppSBudqztn3N1Sqheb6PGaIPH
         TKf/tBz6dw9/CIbYPULobNaBQ39fR545MnTS/ooKdiHs4ItU+r72gxNNijBExJdsYiza
         SJGw==
X-Gm-Message-State: ACgBeo1karXW8TjyA7g5v88X1hC0KT7le1SkfrvmoBV4jNhMAMYBZ3BI
        zH94igOApGqFAXktTiv1RFYEFZ3hQxoy4oIfN0G2WA==
X-Google-Smtp-Source: AA6agR6mgPO8b5a8qN6Hwu+o7a0FkP+RxxtCU71emjql8vwfRr1sKKPmvZKgBtd1GpvHcMIgHHfbiz5NC+pZmkXZatc=
X-Received: by 2002:a05:6512:537:b0:494:8359:4ad with SMTP id
 o23-20020a056512053700b00494835904admr8089979lfc.409.1662360661770; Sun, 04
 Sep 2022 23:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <dfd07f84-c4bd-a18c-2263-49f999f2934c@linaro.org> <f42539d0-c2a3-a2b2-c35b-b7a5904b376f@gmail.com>
 <db00f6a9-263d-9c47-486e-7080ffc5b3c9@linaro.org> <312ede16-f0a9-9b9e-a0d6-fb6e37d9f1bb@gmail.com>
In-Reply-To: <312ede16-f0a9-9b9e-a0d6-fb6e37d9f1bb@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 5 Sep 2022 12:20:50 +0530
Message-ID: <CAFA6WYOS6iw+4e6TW9NLO2-Bk37rZFN_S2J3dyOVvgOcd9CtXA@mail.gmail.com>
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure Application
To:     Maximilian Luz <luzmaximilian@gmail.com>
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
        Ard Biesheuvel <ardb@kernel.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

+ TEE ML

On Fri, 2 Sept 2022 at 18:48, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> Hi,
>
> On 9/2/22 09:26, Sumit Garg wrote:
> > Hi Maximilian,
> >
> > On 02/08/22 18:52, Maximilian Luz wrote:
>
> [...]
>
> >> Thanks for this information! So as far as I understand it, this is currently an
> >> interface to user-space only, i.e. does not allow in-kernel drivers for apps?
> >
> > The Linux TEE framework already provides an in-kernel interface to TEE as well via TEE bus [1]. There are already multiple kernel drivers [2] [3] [4] [5] [6] [7] using it. So an EFI driver can be an addition to that.
> >
> > Now coming on to TEE implementations, the drivers I mentioned are based on OP-TEE where devices are queried/enumerated during OP-TEE probe here [8]. So in similar manner QTEE smcinvoke driver should be able to register devices on the TEE bus.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/staging/tee.rst#n56
> >
> > [2] drivers/char/tpm/tpm_ftpm_tee.c
> >
> > [3] drivers/char/hw_random/optee-rng.c
> >
> > [4] drivers/firmware/arm_scmi/optee.c
> >
> > [5] security/keys/trusted-keys/trusted_tee.c
> >
> > [6] drivers/firmware/broadcom/tee_bnxt_fw.c
> >
> > [7] drivers/rtc/rtc-optee.c
> >
> > [8] drivers/tee/optee/device.c
>
> Thanks for those links!
>
> I think it would indeed be good if we could make it work via that
> interface and I guess that should generally be possible. As far as I can
> see, the biggest problem might be that the current firmware doesn't seem
> to use UUIDs, so I guess we might need to emulate them somehow.
>

Okay, so I had a brief look at your driver to get an idea how QTEE
identifies its trusted/secure applications. AFAIU, it uses constant
strings as follows:

#define QCTEE_UEFISEC_APP_NAME "qcom.tz.uefisecapp"

I think we should be able to extend the TEE bus concept to accept
constant strings as device IDs as well. So if a driver wants to
support both OP-TEE and QTEE based apps then it can put corresponding
identifiers (UUID or a constant string) in the TEE device match ID
table. This way we should be able to support other TEE implementations
as I think any other identifier apart from UUID can be represented as
a constant string.

If anyone else has any better then feel free to discuss.

-Sumit

> It would be great if someone with some actual knowledge of the firmware
> used on those devices could have a look at this and provide some
> insights.
>
> My plan for now is to hold off on the UEFI variable driver until we have
> a (proper) TEE driver, which unfortunately might be a bit out of my
> depth. I'm happy to help out in any way I can though.
>
> Regards,
> Max
