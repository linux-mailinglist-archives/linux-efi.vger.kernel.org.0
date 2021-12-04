Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD457468357
	for <lists+linux-efi@lfdr.de>; Sat,  4 Dec 2021 09:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384235AbhLDIZX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 4 Dec 2021 03:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354766AbhLDIZX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 4 Dec 2021 03:25:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D227C061751;
        Sat,  4 Dec 2021 00:21:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86FA5B807E4;
        Sat,  4 Dec 2021 08:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3985DC341C0;
        Sat,  4 Dec 2021 08:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638606115;
        bh=SximJh3Vd1cQiTCTSxpplR616mpXHOCLhQDR1aplEM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYmfSjOoo1NpRvVK3j1rmFiYbqVs2CEUHktL53fJ/VB40mPNd8e3Yr2y9X6dlnaG3
         bA3ZX5W74sdb6yw/9PzqWvLufv3L8k1ng1ezSJ1sqfV1CtaBkMBCv4J0+FrjjHysKw
         oaKdvNGrlr8qAAOI6pjPSGfprwPyxgbpHdA9bYf4=
Date:   Sat, 4 Dec 2021 09:21:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Subject: Re: [PATCH v3 3/5] Tag e820_entry with crypto capabilities
Message-ID: <YaslH6kSDljPpC5/@kroah.com>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
 <20211203192148.585399-4-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203192148.585399-4-martin.fernandez@eclypsium.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 03, 2021 at 04:21:46PM -0300, Martin Fernandez wrote:
> Add a new member in e820_entry to hold whether an entry is able to do
> hardware memory encryption or not.
> 
> Add a new argument to __e820__range_add to accept this new
> crypto_capable.

Shouldn't this Subject have the same prefix as patch 4/5?

thanks,

greg k-h
