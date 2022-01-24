Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EDA49980B
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jan 2022 22:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353111AbiAXVTY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Jan 2022 16:19:24 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:55055 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448337AbiAXVM2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Jan 2022 16:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643058748; x=1674594748;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=s08kGL1P6vWKXvsndk5HwY8vMXv8Hz2WGGuKsGt7M+M=;
  b=Lt24+Kwh4B2vxFMObDYugoNvzC+0bVYqPVLp4pet6BWgIT7rqAUzfT0e
   ZZgVZhu0LqdjiHOV0RwGKa5xn6p6D6SDHea6XhMdMz6Bkkplo/KuTD8Yc
   DRiP8b+zP0CvKjJmo0dG8EzEygfor9G9x/oBVJMOBl2s5YYvjpiuX+n8C
   E=;
X-IronPort-AV: E=Sophos;i="5.88,313,1635206400"; 
   d="scan'208";a="171375781"
Subject: Re: [PATCH 1/3] memblock: define functions to set the usable memory range
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 24 Jan 2022 21:05:45 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com (Postfix) with ESMTPS id 3023081139;
        Mon, 24 Jan 2022 21:05:39 +0000 (UTC)
Received: from EX13D19UEB001.ant.amazon.com (10.43.60.16) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.129) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 24 Jan 2022 21:05:39 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D19UEB001.ant.amazon.com (10.43.60.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 24 Jan 2022 21:05:39 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Mon, 24 Jan 2022 21:05:38
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 1DC072A; Mon, 24 Jan 2022 21:05:38 +0000 (UTC)
Date:   Mon, 24 Jan 2022 21:05:38 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Mike Rapoport <rppt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <ardb@kernel.org>, <linux-mm@kvack.org>,
        <devicetree@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <geert+renesas@glider.be>
Message-ID: <20220124210538.GA15943@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
 <20220110210809.3528-2-fllinden@amazon.com> <Yd1cnquQFZoNE7FP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yd1cnquQFZoNE7FP@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Meanwhile, it seems that this issue was already addressed in:

https://lore.kernel.org/all/20211215021348.8766-1-kernelfans@gmail.com/

..which has now been pulled in, and sent to stable@ for 5.15. I
somehow missed that message, and sent my change in a few weeks
later.

The fix to just reserve the ranges does seem a bit cleaner overall,
but this will do fine.

Thanks!

- Frank
