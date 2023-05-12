Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B260F700902
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 15:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbjELNUK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 09:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbjELNTw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 09:19:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A65132AD;
        Fri, 12 May 2023 06:19:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683897587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zu7AfHp+nm/4M5jR+Z/9talnCB0FHmaOcfCKY0ExWO0=;
        b=Mv9Tnyleh7o156tZl7skdqEY9qCBJz6dksvLEdOa+yzTm+I0JUHG12vtOfaEavn2XFUV+J
        2YImu1GyQDLO8IXPanqrURZNIkleLjpQ8Pq85f/RabyZ/ClbVEcsVRgNgUdqFbXEdBGiAa
        shO+EMJCz1Rut6q/sAlYzwcdpq+/9zvHBH1a2MDMLLR4eQV6bgXggrisG1AmQs4SObe+Pp
        8qvuu+edP329yd2l9IZVEYaR7Cxdmk+bvyt7YqEr1VBH/O/hItT9+mXJP1Lu6Fa2DMqxB+
        ypSuYsbkS+u7EoCa3mE8EuSajPLtui4VnpAhMTjSQWJ1ZrU7lTVLBgZZ/ctaFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683897587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zu7AfHp+nm/4M5jR+Z/9talnCB0FHmaOcfCKY0ExWO0=;
        b=jKVLpN1id/BmCGXWrrcd7uzWgYU1EkSu1Z+3gHgioy0/F4/PQqHJSGHugtA3q1+ZJQiL+8
        hypwdRPxcX164PBA==
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
In-Reply-To: <20230504145023.835096-3-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
Date:   Fri, 12 May 2023 15:19:46 +0200
Message-ID: <87sfc1bsb1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 04 2023 at 14:50, Ross Philipson wrote:
> +KASLR Configuration
> +-------------------
> +
> +Secure Launch does not interoperate with KASLR. If possible, the MLE should be
> +built with KASLR disabled::

Why?

> +  "Processor type and features" -->
> +      "Build a relocatable kernel" -->
> +          "Randomize the address of the kernel image (KASLR) [ ]"
> +
> +This unsets the Kconfig value CONFIG_RANDOMIZE_BASE.
> +
> +If not possible, KASLR must be disabled on the kernel command line when doing
> +a Secure Launch as follows::
> +
> +  nokaslr

So what happens if KASLR is enabled in Kconfig and not disabled on the
command line?

> +IOMMU Configuration
> +-------------------
> +
> +When doing a Secure Launch, the IOMMU should always be enabled and the drivers
> +loaded. However, IOMMU passthrough mode should never be used. This leaves the
> +MLE completely exposed to DMA after the PMR's [2]_ are disabled. The current default
> +mode is to use IOMMU in lazy translated mode but strict translated mode is the preferred
> +IOMMU mode and this should be selected in the build configuration::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "IOMMU default domain type" -->
> +              "(X) Translated - Strict"
> +
> +In addition, the Intel IOMMU should be on by default. The following sets this as the
> +default in the build configuration::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "Support for Intel IOMMU using DMA Remapping Devices [*]"
> +
> +and::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "Support for Intel IOMMU using DMA Remapping Devices [*]" -->
> +              "Enable Intel DMA Remapping Devices by default  [*]"
> +
> +It is recommended that no other command line options should be set to override
> +the defaults above.

Is any of this validated and are proper warnings emitted or is it just
recommended and left to the user to do the right thing?

Thanks,

        tglx
