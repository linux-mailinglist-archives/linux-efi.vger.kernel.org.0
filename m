Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BC94A9A17
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 14:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354889AbiBDNiO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Feb 2022 08:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiBDNiO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Feb 2022 08:38:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E6AC061714;
        Fri,  4 Feb 2022 05:38:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4F23B8373A;
        Fri,  4 Feb 2022 13:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CC3C004E1;
        Fri,  4 Feb 2022 13:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643981890;
        bh=ADsLWrDPUHmAqFOd35u++j4ThxtN9Oz6/99IGv9oiic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEBVddxxEGZ8Z/cP1AXKMf6eHPQ9U6NMkiaKUe7OdNODPCCunKqCWLvufroq8oqo+
         IgLv5eRgIdm/TmPaDZ8qWYCU57rA6tK3EIHQqzn5BgEP1BNl/UXF26nhcm5Wcm3Kns
         /dLBxNDC+S2C+0uUZEianRM9pmGbgYOvQzcGCRuR+Jsyywhf3eMVTaMzjGuZX6NSRn
         R3DkFb2EXoy6v5eAuyUYxWq2eLHkQ8mwiPMSGb3qf1ccmUtTjBRbhFjhJ2zYtPuQqi
         Zaxm9eILt6xbeMwAyuMOxYY21i1+ya9QM4ylXTdD6PCs+OnA91cqLXuFafI9zy+XjR
         oYuJbZz7DegHQ==
Date:   Fri, 4 Feb 2022 15:37:56 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Subject: Re: [PATCH v6 6/6] drivers/node: Show in sysfs node's crypto
 capabilities
Message-ID: <Yf0sNKu1vJkIRAA3@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
 <Yfyx8s9n+CZ6TPgg@kernel.org>
 <CAKgze5YZF09F3FTwD6kODd2RrWATutcmM5J7-wcLTK32C6aptg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgze5YZF09F3FTwD6kODd2RrWATutcmM5J7-wcLTK32C6aptg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 04, 2022 at 09:27:42AM -0300, Martin Fernandez wrote:
> On 2/4/22, Mike Rapoport <rppt@kernel.org> wrote:
> > On Thu, Feb 03, 2022 at 01:43:28PM -0300, Martin Fernandez wrote:
> >> +Description:
> >> +		This value is 1 if all system memory in this node is
> >> +		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
> >
> > It didn't jump at me at previous postings, but other architectures won't
> > necessary have EFI_MEMORY_CPU_CRYPTO marking crypto-capable memory.
> >
> > How about
> >
> >   This value is 1 if all system memory in this node is capable of being
> >   protected with the CPU's memory cryptographic capabilities. It is 0
> >   otherwise.
> >   On EFI architectures with value corresponds to EFI_MEMORY_CPU_CRYPTO.
> >
> >
> 
> Yes, sounds good to me.
> 
> Is there other architecture with something similar to this? Or are you
> thinking on the possibility of such architecture?

AFAIU, s390 and powerpc have memory encryption capabilities, I don't know
the details though. 

-- 
Sincerely yours,
Mike.
