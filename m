Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E068362C997
	for <lists+linux-efi@lfdr.de>; Wed, 16 Nov 2022 21:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKPUIc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiKPUIb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 15:08:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78672BF0;
        Wed, 16 Nov 2022 12:08:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A171EB81D83;
        Wed, 16 Nov 2022 20:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42EAC433D6;
        Wed, 16 Nov 2022 20:08:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gi1c1/+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668629302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L+lac/9Nxb5wUqkltEH21OF/Yf9EDeqLnEARlz2sdDc=;
        b=gi1c1/+YTN6caDPSNaF4jbxVz1ku9QzNsV+SE4KyBXhEWC1kYzzbiSa9uqBm5u3OC4sCYn
        vLTn9E3EZNIek1knqMNs7ffLz3a2N4soKS6vWIfWQ9PndXWJvhvGeBW9HeTYZzYn4abA2G
        q111OWcr1tKaBAr9X52t7BstgyVujaM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5465c683 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 20:08:22 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id b81so8862979vkf.1;
        Wed, 16 Nov 2022 12:08:22 -0800 (PST)
X-Gm-Message-State: ANoB5pmQ6JwVFVqIzfpKwJQsYBHlQxVYbnC/OVAXEoLrAdjXrT6B6UhT
        2LbLXOuelXpOzowxcSWqHopxsdwlVDFcs2mnawc=
X-Google-Smtp-Source: AA0mqf7dAEsP77ebcrTPJrzxfnhbd/CrgIqF4+nvPipC3MN0yy0SWr3tJsJhyxTSvQVUB65cCeWO+il4UaJXLljsGss=
X-Received: by 2002:a05:6122:1883:b0:376:5afd:d30c with SMTP id
 bi3-20020a056122188300b003765afdd30cmr13534613vkb.13.1668629302032; Wed, 16
 Nov 2022 12:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20221116161642.1670235-1-Jason@zx2c4.com> <20221116161642.1670235-6-Jason@zx2c4.com>
 <CAMj1kXHZ60DCz6zgOqfQ-jBEuhc3XwvhieNbJUCY40hdEWt9CQ@mail.gmail.com> <7837b12a39b1d6721387ca95554c79003bd16c4e.camel@HansenPartnership.com>
In-Reply-To: <7837b12a39b1d6721387ca95554c79003bd16c4e.camel@HansenPartnership.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 16 Nov 2022 21:08:10 +0100
X-Gmail-Original-Message-ID: <CAHmME9obGun7zEMKQ1Td4u+rnzi3MexaUAj30W5UMYvJ62mw3Q@mail.gmail.com>
Message-ID: <CAHmME9obGun7zEMKQ1Td4u+rnzi3MexaUAj30W5UMYvJ62mw3Q@mail.gmail.com>
Subject: Re: [PATCH RFC v1 5/6] efi: efivarfs: prohibit reading random seed variables
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 16, 2022 at 8:42 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> It would be nice if they could be boot services only ... then they
> disappear naturally, but that would mean the rng would have to
> initialize and save in the EFI stub before ExitBootServices, which
> doesn't seem practical.

That would be nice, but the whole idea is it gets updated by Linux's
RNG, so that won't work. `boot|runtime` it is, then.

Jason
