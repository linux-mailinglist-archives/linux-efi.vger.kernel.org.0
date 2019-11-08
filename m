Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055DBF45C1
	for <lists+linux-efi@lfdr.de>; Fri,  8 Nov 2019 12:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbfKHLeI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Nov 2019 06:34:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49468 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730151AbfKHLeH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 Nov 2019 06:34:07 -0500
Received: from zn.tnic (p200300EC2F0D3700695E5CE6DC2DF0A9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:3700:695e:5ce6:dc2d:f0a9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45CDA1EC0D07;
        Fri,  8 Nov 2019 12:34:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573212842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TWDpW7BKkDopDCvkvhD+QBnVNOTmR7yWGxULIMb5Nrk=;
        b=PhQdlHmcw8mnoi7s80WzWL6ImNNgWUN2xwJrJkT+REzQWP0b392vJZo2+GsmlqPnGPvSHr
        z5ocXKnO4n1wabBmA8zu3RV6xVdnVmIdGawMlgxcdLC1qiKQlpa9Ad7UYES71SpiNjSdqL
        /RWxBJj66K0Zf8Dhv1LIuKLnf/Be4q0=
Date:   Fri, 8 Nov 2019 12:33:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, eric.snowberg@oracle.com, hpa@zytor.com,
        jgross@suse.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 3/3] x86/boot: Introduce the setup_indirect
Message-ID: <20191108113356.GC4503@zn.tnic>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
 <20191104151354.28145-4-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191104151354.28145-4-daniel.kiper@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 04, 2019 at 04:13:54PM +0100, Daniel Kiper wrote:
> diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
> index edaa30b20841..701a98300f86 100644
> --- a/arch/x86/kernel/kdebugfs.c
> +++ b/arch/x86/kernel/kdebugfs.c
> @@ -44,7 +44,11 @@ static ssize_t setup_data_read(struct file *file, char __user *user_buf,
>  	if (count > node->len - pos)
>  		count = node->len - pos;
>  
> -	pa = node->paddr + sizeof(struct setup_data) + pos;
> +	pa = node->paddr + pos;
> +
> +	if (!(node->type & SETUP_INDIRECT) || node->type == SETUP_INDIRECT)

This check looks strange at a first glance and could use a comment.

> +		pa += sizeof(struct setup_data);
> +
>  	p = memremap(pa, count, MEMREMAP_WB);
>  	if (!p)
>  		return -ENOMEM;
> @@ -108,9 +112,17 @@ static int __init create_setup_data_nodes(struct dentry *parent)
>  			goto err_dir;
>  		}
>  
> -		node->paddr = pa_data;
> -		node->type = data->type;
> -		node->len = data->len;
> +		if (data->type == SETUP_INDIRECT &&
> +		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> +			node->paddr = ((struct setup_indirect *)data->data)->addr;
> +			node->type = ((struct setup_indirect *)data->data)->type;
> +			node->len = ((struct setup_indirect *)data->data)->len;

Align them vertically on the "=" sign even if they stick out over the
80-cols rule.

> +		} else {
> +			node->paddr = pa_data;
> +			node->type = data->type;
> +			node->len = data->len;
> +		}
> +
>  		create_setup_data_node(d, no, node);
>  		pa_data = data->next;
>  
> diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
> index 7969da939213..14ef8121aa53 100644
> --- a/arch/x86/kernel/ksysfs.c
> +++ b/arch/x86/kernel/ksysfs.c
> @@ -100,7 +100,11 @@ static int __init get_setup_data_size(int nr, size_t *size)
>  		if (!data)
>  			return -ENOMEM;
>  		if (nr == i) {
> -			*size = data->len;
> +			if (data->type == SETUP_INDIRECT &&
> +			    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
> +				*size = ((struct setup_indirect *)data->data)->len;
> +			else
> +				*size = data->len;

<---- newline here.

>  			memunmap(data);
>  			return 0;
>  		}
> @@ -130,7 +134,10 @@ static ssize_t type_show(struct kobject *kobj,
>  	if (!data)
>  		return -ENOMEM;
>  
> -	ret = sprintf(buf, "0x%x\n", data->type);
> +	if (data->type == SETUP_INDIRECT)
> +		ret = sprintf(buf, "0x%x\n", ((struct setup_indirect *)data->data)->type);
> +	else
> +		ret = sprintf(buf, "0x%x\n", data->type);
>  	memunmap(data);
>  	return ret;
>  }
> @@ -142,7 +149,7 @@ static ssize_t setup_data_data_read(struct file *fp,
>  				    loff_t off, size_t count)
>  {
>  	int nr, ret = 0;
> -	u64 paddr;
> +	u64 paddr, len;
>  	struct setup_data *data;
>  	void *p;
>  
> @@ -157,19 +164,28 @@ static ssize_t setup_data_data_read(struct file *fp,
>  	if (!data)
>  		return -ENOMEM;
>  
> -	if (off > data->len) {
> +	if (data->type == SETUP_INDIRECT &&
> +	    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> +		paddr = ((struct setup_indirect *)data->data)->addr;
> +		len = ((struct setup_indirect *)data->data)->len;
> +	} else {
> +		paddr += sizeof(*data);
> +		len = data->len;
> +	}
> +
> +	if (off > len) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
> -	if (count > data->len - off)
> -		count = data->len - off;
> +	if (count > len - off)
> +		count = len - off;
>  
>  	if (!count)
>  		goto out;
>  
>  	ret = count;
> -	p = memremap(paddr + sizeof(*data), data->len, MEMREMAP_WB);
> +	p = memremap(paddr, len, MEMREMAP_WB);
>  	if (!p) {
>  		ret = -ENOMEM;
>  		goto out;
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 77ea96b794bd..4603702dbfc1 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -438,6 +438,10 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  	while (pa_data) {
>  		data = early_memremap(pa_data, sizeof(*data));
>  		memblock_reserve(pa_data, sizeof(*data) + data->len);

<---- newline here.

> +		if (data->type == SETUP_INDIRECT &&
> +		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
> +			memblock_reserve(((struct setup_indirect *)data->data)->addr,
> +					 ((struct setup_indirect *)data->data)->len);

<---- newline here.

Let's space that statement out for better readability.

>  		pa_data = data->next;
>  		early_memunmap(data, sizeof(*data));
>  	}
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index a39dcdb5ae34..1ff9c2030b4f 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -626,6 +626,17 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>  		paddr_next = data->next;
>  		len = data->len;
>  
> +		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> +			memunmap(data);
> +			return true;
> +		}
> +
> +		if (data->type == SETUP_INDIRECT &&
> +		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> +			paddr = ((struct setup_indirect *)data->data)->addr;
> +			len = ((struct setup_indirect *)data->data)->len;
> +		}
> +
>  		memunmap(data);
>  
>  		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
> -- 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
