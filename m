Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9A246B3D2
	for <lists+linux-efi@lfdr.de>; Tue,  7 Dec 2021 08:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhLGH2v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Dec 2021 02:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLGH2v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Dec 2021 02:28:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A5C061746;
        Mon,  6 Dec 2021 23:25:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5098CE19C0;
        Tue,  7 Dec 2021 07:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4DAC341C1;
        Tue,  7 Dec 2021 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638861917;
        bh=3+EBEsclmdbVbmRJP9A28/FcBv3FGPKlb25nC+tN2eY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5YgUf73UNZ0b/yOZ3VUpPzUsCta77XV7QUKl31k8FH9jWb6pGCNEN8yXiwmC0Y71
         jTPwiSpJg1Sf5FsypTQENIUj1xQWjAXgb8Inrwnl0wDGAc5YPJo5ceZjdphsEbtvZ0
         f5MQNQDYRf9ykL8gxqCX1ASNQYmMyFlcTzxhMQ6M2+1r/rwBoiWE4GkJGzlJujDMSP
         /AzN7MAAdq5NM/Khl1lfjL4IOLT0B3RQTOnw/pQSeUutJa2vuTSAfDl1fU9NTDiXgY
         C5sNIWghTjrwiaGN30TWcgVKcxmcvSrrLeIR20A6HOSQOqTzV6qxJOmCqtG8ZBHX3q
         Y54HQXzKWkbzw==
Date:   Tue, 7 Dec 2021 09:25:04 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com
Subject: Re: [PATCH v3 0/5] x86: Show in sysfs if a memory node is able to do
 encryption
Message-ID: <Ya8MUOKPOKVfBfjJ@kernel.org>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
 <YaxWXACBguZxWmKS@kernel.org>
 <CAD2FfiG9wfeW_2xxZqBi9vsjzEJBRjJUZw+AQy1Taos4fh2TLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2FfiG9wfeW_2xxZqBi9vsjzEJBRjJUZw+AQy1Taos4fh2TLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Richard,

On Mon, Dec 06, 2021 at 07:58:10PM +0000, Richard Hughes wrote:
> On Sun, 5 Dec 2021 at 06:04, Mike Rapoport <rppt@kernel.org> wrote:
> > On Fri, Dec 03, 2021 at 04:21:43PM -0300, Martin Fernandez wrote:
> > > fwupd project plans to use it as part of a check to see if the users
> > > have properly configured memory hardware encryption capabilities.
> > I'm missing a description about *how* the new APIs/ABIs are going to be
> > used.
> 
> We're planning to use this feature in the Host Security ID checks done
> at every boot. Please see
> https://fwupd.github.io/libfwupdplugin/hsi.html for details. I'm happy
> to answer questions or concerns. Thanks!

Can you please describe the actual check for the memory encryption and how
it would impact the HSI rating?

I wonder, for example, why did you choose per-node reporting rather than
per-region as described in UEFI spec.

-- 
Sincerely yours,
Mike.
