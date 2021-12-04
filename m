Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB9246835A
	for <lists+linux-efi@lfdr.de>; Sat,  4 Dec 2021 09:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384257AbhLDIZ6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 4 Dec 2021 03:25:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54824 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhLDIZ5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 4 Dec 2021 03:25:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E53FECE1DF9;
        Sat,  4 Dec 2021 08:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94264C341C0;
        Sat,  4 Dec 2021 08:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638606149;
        bh=b4KdFEuyeTDkLRxTBS/8EoeINyZKLJit3rrz0W8btQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dlLLOCnGeCwxKahR1hZVwxkC9YXA1U6VO7mAvQGe0DgPkTcQNOO6O5S7IVMmI/WSc
         G7ejFjsP9j/KsuDMASZreQ2mTY/+NO/Bu1i++Osc6KDBSjBT1aT86COTxUD/cKiZ6A
         T27mVcDDC6a5TCfr3iduF2FkJyLjr/KCJZRb2bGs=
Date:   Sat, 4 Dec 2021 09:22:24 +0100
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
Subject: Re: [PATCH v3 5/5] drivers/node: Show in sysfs node's crypto
 capabilities
Message-ID: <YaslQCg2G1pWUPVV@kroah.com>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
 <20211203192148.585399-6-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203192148.585399-6-martin.fernandez@eclypsium.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 03, 2021 at 04:21:48PM -0300, Martin Fernandez wrote:
> Show in each node in sysfs if its memory is able to do be encrypted by
> the CPU, ie. if all its memory is marked with EFI_MEMORY_CPU_CRYPTO in
> the EFI memory map.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  drivers/base/node.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index b5a4ba18f9f9..67b0e2fa93b1 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -560,11 +560,21 @@ static ssize_t node_read_distance(struct device *dev,
>  }
>  static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>  
> +static ssize_t crypto_capable_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct pglist_data *pgdat = NODE_DATA(dev->id);
> +
> +	return sysfs_emit(buf, "%d\n", pgdat->crypto_capable);
> +}
> +static DEVICE_ATTR_RO(crypto_capable);
> +
>  static struct attribute *node_dev_attrs[] = {
>  	&dev_attr_meminfo.attr,
>  	&dev_attr_numastat.attr,
>  	&dev_attr_distance.attr,
>  	&dev_attr_vmstat.attr,
> +	&dev_attr_crypto_capable.attr,
>  	NULL
>  };

You forgot a Documentation/ABI/ update for this new sysfs file you
added :(
