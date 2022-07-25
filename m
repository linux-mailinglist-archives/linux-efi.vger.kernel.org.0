Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D7580470
	for <lists+linux-efi@lfdr.de>; Mon, 25 Jul 2022 21:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiGYT1L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Jul 2022 15:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiGYT1K (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Jul 2022 15:27:10 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7E0A45A;
        Mon, 25 Jul 2022 12:27:08 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id bb16so14655316oib.11;
        Mon, 25 Jul 2022 12:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=biplv8ZnovJJIoreJcaFobXzSk+jEJJVI0kZQA2bmqY=;
        b=uqu+6HMtKu11PhWQkaU8nbwJVlQTV/9vlUq1cXkrYdZOPv8bLGAH+0AD+SE0zxCgS/
         C/CaT5IbrfRsC6D8JiDcJzs0f/rQNvtrKpd+j3eG0O97cr/p9ls0Ni9SvEfTEJcv4XPj
         zH7HK5wKq7lquBgvUeFNCnHmJa4zBv0zD4qRE2tGCE12N+HqlduAGkXnBleTofD3cqPW
         7u+CfBeNaNUs7OvLtnBCyEt2atwaJhEamm6eOinbeC/hCt/+QeZJn3FyuXbjcdqG9//O
         vL9+l0+Nhp7GkWNBTg/XRnEENZsFYWc1Nlz1C/qiHbK8RmM1B96DfnoSZCrAxHqJG6D/
         L2zQ==
X-Gm-Message-State: AJIora92tBFTEYVrCiRcTFP4s0R/xiL0ejRElC/MjsBUfCxOq2S7l/Bu
        yLSFyMQfUDkhivB9s+xzvw==
X-Google-Smtp-Source: AGRyM1sHRDiIqGa4CnHexl48xYWTF6EUArhGrzGDOK0Z9M8NJdDZGNdX/YvkELxDpJNw/dF1MbyF6A==
X-Received: by 2002:a05:6808:1a88:b0:33a:a573:c1a0 with SMTP id bm8-20020a0568081a8800b0033aa573c1a0mr11389536oib.222.1658777228095;
        Mon, 25 Jul 2022 12:27:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w7-20020a4aca07000000b0041ba304546csm5176012ooq.1.2022.07.25.12.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 12:27:07 -0700 (PDT)
Received: (nullmailer pid 2550854 invoked by uid 1000);
        Mon, 25 Jul 2022 19:27:05 -0000
Date:   Mon, 25 Jul 2022 13:27:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Message-ID: <20220725192705.GA2536409-robh@kernel.org>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723224949.1089973-1-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jul 24, 2022 at 12:49:45AM +0200, Maximilian Luz wrote:
> On modern Qualcomm platforms, access to EFI variables is restricted to
> the secure world / TrustZone, i.e. the Trusted Execution Environment
> (TrEE or TEE) as Qualcomm seems to call it. To access EFI variables, we
> therefore need to talk to the UEFI Secure Application (uefisecapp),
> residing in the TrEE.

The whole point of UEFI is providing a standard interface. Why can't the 
UEFI implementation call the TEE itself?

I'm not sure custom interfaces is something we want.


> This series adds support for accessing EFI variables on those platforms.
> 
> To do this, we first need to add some SCM call functions used to manage
> and talk to Secure Applications. A very small subset of this interface
> is added in the second patch (whereas the first one exports the required
> functions for that). Interface specifications are extracted from [1].
> While this does not (yet) support re-entrant SCM calls (including
> callbacks and listeners), this is enough to talk to the aforementioned
> uefisecapp on a couple of platforms (I've tested this on a Surface Pro X
> and heard reports from Lenovo Flex 5G, Lenovo Thinkpad x13s, and Lenovo
> Yoga C630 devices).

What does Windows do on these devices? I'm surprised something like this 
would fly with Microsoft.

Rob
