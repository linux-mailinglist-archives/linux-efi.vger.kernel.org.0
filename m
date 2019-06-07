Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D45396BE
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jun 2019 22:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfFGUXe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jun 2019 16:23:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbfFGUXe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jun 2019 16:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=29IHtlE/6a2OmsjukbA5ARdURIqIUHQIsBKMPglCt88=; b=euVUIRYYwirfKp1eF63MPhWtA
        h65H/xfzayNNM0RK/crrmRly06xyRlwtDyji01aJeYiGVMptnaDAKUx9v3C+Tj9+gAuorKlIW4S82
        d5CbwG/lfyaVEto7ZGvkHohrnf1BDq3S8TNorgQtXkHeOO6qeNxRcHtxWT70zbL09KPXIXLcOztpf
        WPbsInwzqHPV5HeY/6U6DSshJLL2Euuq3AozPw2bsWLcfaArkkWmvnnj4yL9+n801n1I86FcCBnLM
        CIYfFTKfY0lcDpIOXbzn/F6YLyZo/q8T9EN7vbD4EZn1M12pslE/PKEydQVfUEp9iW4P2VRlNvlpo
        XJ8JVqfJA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZLOe-0006dJ-IG; Fri, 07 Jun 2019 20:23:32 +0000
Date:   Fri, 7 Jun 2019 13:23:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        linux-nvdimm@lists.01.org, x86@kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v3 07/10] lib/memregion: Uplevel the pmem "region" ida to
 a global allocator
Message-ID: <20190607202332.GB32656@bombadil.infradead.org>
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993567002.3036719.5748845658364934737.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155993567002.3036719.5748845658364934737.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 07, 2019 at 12:27:50PM -0700, Dan Williams wrote:
> diff --git a/lib/memregion.c b/lib/memregion.c
> new file mode 100644
> index 000000000000..f6c6a94c7921
> --- /dev/null
> +++ b/lib/memregion.c
> @@ -0,0 +1,15 @@
> +#include <linux/idr.h>
> +
> +static DEFINE_IDA(region_ids);
> +
> +int memregion_alloc(gfp_t gfp)
> +{
> +	return ida_alloc(&region_ids, gfp);
> +}
> +EXPORT_SYMBOL(memregion_alloc);
> +
> +void memregion_free(int id)
> +{
> +	ida_free(&region_ids, id);
> +}
> +EXPORT_SYMBOL(memregion_free);

Does this trivial abstraction have to live in its own file?  I'd make
memregion_alloc/free static inlines that live in a header file, then
all you need do is find a suitable .c file to store memregion_ids in,
and export that one symbol instead of two.
