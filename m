Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450A3468619
	for <lists+linux-efi@lfdr.de>; Sat,  4 Dec 2021 17:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350370AbhLDQJK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 4 Dec 2021 11:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbhLDQJJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 4 Dec 2021 11:09:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407E8C061751;
        Sat,  4 Dec 2021 08:05:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD7B60EAC;
        Sat,  4 Dec 2021 16:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897C0C341C2;
        Sat,  4 Dec 2021 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638633943;
        bh=o1O9LmUdjqsQPV5YfC4LWxo9o42K7wj4e2mA0GGl5kA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MY7L9hs2Ruv1BDZ+Yj+J1gXqZzRhlxzYN5IVYNwklt5dA4QV0m1LuBWfm9vo+nQ8V
         SnNr2ohL/6L/IHzAqC5VY+N/fGaW+WTnlBY45A1p0gFRLhqOeUX2ZvlKgXt/tCz1NI
         v4AUQxtTViAkDrcVTwQN9YDzwVXtV1wS5fB6w0WrfOI8poUKy66y2gTpMIVJYd1wTm
         G6fJ4wvQ9W3ClzKPyqiK8O6l+FhSQ5c2MEayhcLRz8Rt9ew0mJFc8lxKpaFD/yk4Mw
         yAE4b6kKTMRE3MNMGjgRFCiWi0kp1wgf4d9fDAnYjJ3Jzoz9PvXTw9aVJb2sTqz4OD
         LPQ4nZSxdjWyA==
Date:   Sat, 4 Dec 2021 18:05:30 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        rafael@kernel.org, akpm@linux-foundation.org,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Subject: Re: [PATCH v3 3/5] Tag e820_entry with crypto capabilities
Message-ID: <YauRykMtyjNKTp+q@kernel.org>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
 <20211203192148.585399-4-martin.fernandez@eclypsium.com>
 <YaslH6kSDljPpC5/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaslH6kSDljPpC5/@kroah.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 04, 2021 at 09:21:51AM +0100, Greg KH wrote:
> On Fri, Dec 03, 2021 at 04:21:46PM -0300, Martin Fernandez wrote:
> > Add a new member in e820_entry to hold whether an entry is able to do
> > hardware memory encryption or not.
> > 
> > Add a new argument to __e820__range_add to accept this new
> > crypto_capable.
> 
> Shouldn't this Subject have the same prefix as patch 4/5?

I'd say it should be x86/e820
 
> thanks,
> 
> greg k-h

-- 
Sincerely yours,
Mike.
