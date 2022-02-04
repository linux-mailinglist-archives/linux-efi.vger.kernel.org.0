Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373054A9328
	for <lists+linux-efi@lfdr.de>; Fri,  4 Feb 2022 05:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiBDE4d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Feb 2022 23:56:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42790 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356982AbiBDE4d (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 3 Feb 2022 23:56:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22E7EB82D13;
        Fri,  4 Feb 2022 04:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08D9C004E1;
        Fri,  4 Feb 2022 04:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643950590;
        bh=2EmWtJLe29ETngENO8GwR9Ivq4C7OKoWb/fS1NF8720=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zhj7KkI36PEB+9i0tF8Izc2xDXCgDa7iK/YTF4bNHhsEL1pw6cIJhWtM7we1pwHwL
         B1lGjQg6RNPg01qKSjfY7yLJMTBCHV+pkHwE7AANySlq9BmMdUbF87pzkFuQrv7v4v
         NMJdWdnkwwUe+v0Z+zXLn4Y5sdWOHcVeo1ITLX/PFLOuGzt0upQmkcf3KbPIaAEPHY
         5RWdbC7r27/uDQHn6igTp59syjQHajS7LX70OifyGnowdjibgAMWZ5Z3wxu/Yr8thH
         FjY4lUshIvv4NM5aYiV0s+ivUrMYwe7kOS08LwQRMO/htC1stju/J+rpFVTnzP623L
         Il9zUO6AF48nw==
Date:   Fri, 4 Feb 2022 06:56:18 +0200
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
Message-ID: <Yfyx8s9n+CZ6TPgg@kernel.org>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-7-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203164328.203629-7-martin.fernandez@eclypsium.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 03, 2022 at 01:43:28PM -0300, Martin Fernandez wrote:
> Show in each node in sysfs if its memory is able to do be encrypted by
> the CPU, ie. if all its memory is marked with EFI_MEMORY_CPU_CRYPTO in
> the EFI memory map.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-node | 10 ++++++++++
>  drivers/base/node.c                          | 10 ++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-node
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-node b/Documentation/ABI/testing/sysfs-devices-node
> new file mode 100644
> index 000000000000..0d1fd86c9faf
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-node
> @@ -0,0 +1,10 @@
> +What:		/sys/devices/system/node/nodeX/crypto_capable
> +Date:		February 2022
> +Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
> +Users:		fwupd (https://fwupd.org)
> +Description:
> +		This value is 1 if all system memory in this node is
> +		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the

It didn't jump at me at previous postings, but other architectures won't
necessary have EFI_MEMORY_CPU_CRYPTO marking crypto-capable memory. 

How about

  This value is 1 if all system memory in this node is capable of being
  protected with the CPU's memory cryptographic capabilities. It is 0
  otherwise.
  On EFI architectures with value corresponds to EFI_MEMORY_CPU_CRYPTO.


> +		system memory is capable of being protected with the
> +		CPU’s memory cryptographic capabilities. It is 0
> +		otherwise.
> \ No newline at end of file
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 87acc47e8951..dabaed997ecd 100644
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
>  
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
