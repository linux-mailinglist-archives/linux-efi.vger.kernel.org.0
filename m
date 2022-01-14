Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10D48E172
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jan 2022 01:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiANAW4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jan 2022 19:22:56 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:48237 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiANAWz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jan 2022 19:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1642119776; x=1673655776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LROlsoL05Z/yvNn6y7/I7ailLszh8WniXNKZEpZSJhs=;
  b=KSdxuQRPm0cTFEYksRYRdQmsCM3Q8ZnReXTb0MXyiREryVCREO8BPn7F
   J1PK8F7AbYFKbH7Kv3ZpYfjv1wWqgGCZHOux/6GlVEomKum4mllqqftI3
   ZxIv9Q0Pyez1Yl9BF+6JMk44rLSi6Fqofjuv5n+uiqVqbfPERxboqWO1m
   s=;
X-IronPort-AV: E=Sophos;i="5.88,286,1635206400"; 
   d="scan'208";a="170316158"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-05e8af15.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 14 Jan 2022 00:22:54 +0000
Received: from EX13MTAUEE002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-05e8af15.us-west-2.amazon.com (Postfix) with ESMTPS id 73AC4A2389;
        Fri, 14 Jan 2022 00:22:53 +0000 (UTC)
Received: from EX13D21UEE002.ant.amazon.com (10.43.62.64) by
 EX13MTAUEE002.ant.amazon.com (10.43.62.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 14 Jan 2022 00:22:53 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D21UEE002.ant.amazon.com (10.43.62.64) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Fri, 14 Jan 2022 00:22:52 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Fri, 14 Jan 2022 00:22:52
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id AE751C6; Fri, 14 Jan 2022 00:22:52 +0000 (UTC)
Date:   Fri, 14 Jan 2022 00:22:52 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <ardb@kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <geert+renesas@glider.be>
Subject: Re: [PATCH 1/3] memblock: define functions to set the usable memory
 range
Message-ID: <20220114002252.GA22602@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
 <20220110210809.3528-2-fllinden@amazon.com> <Yd1cnquQFZoNE7FP@kernel.org>
 <20220111204441.GA36458@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <YeBiV8fuCCLWyHYb@kernel.org>
 <20220114001046.GA10609@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220114001046.GA10609@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jan 14, 2022 at 12:10:46AM +0000, Frank van der Linden wrote:
> Thanks for discussing this further! I tried the above change, although
> I wrapped it in an if (cap_mem_size != 0), so that a normal kernel
> doesn't get its entire memory marked as reserved.

Just to clarify: I had to do that because the code is slightly different
on 5.15, where I tried it. It wasn't a bug in the proposed patch.

Anyway, will try 5.17-rc tomorrow, I'll let you know, thanks again.

- Frank
