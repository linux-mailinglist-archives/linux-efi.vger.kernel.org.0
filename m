Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B384650F0C9
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 08:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiDZGTV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 02:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiDZGTU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 02:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0388DF9C;
        Mon, 25 Apr 2022 23:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49B7E61326;
        Tue, 26 Apr 2022 06:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5D4C385A0;
        Tue, 26 Apr 2022 06:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650953772;
        bh=nYuaXwecRqocWNSO0IMukcA++Ke8EmLWPmKT9nO2mTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwGkwkJVPM5PhoYnz/IGbCx0DopfsKD+i1Uz7Yq4+Cw4QY1Fb7pZzoZwQVDd6VyQw
         aJniZzcytOPfhmcr/VhcHoTVcYmyoX9LCy31/55k1ca6GbHMxr1lHdswqQSOvHA6ML
         I9Hr0qk3tZ/SENiwGtQ9MrcRxaGfwuF5VbDLMowHTqrwoFDGrCJtiBa0xilAxOpgjc
         bAWsNs4R8+aZXeaUjsLqX2Ti8z6ujUIDNJ57X7JWnQWIwfjDqL5Q0SfX8JdB7p9pty
         L9yz4/A6b4z8SYTTxwIWD9Q9ul29QK0kaLNglYn2bggNwzJpcun+b87uBDL8kjgQEn
         t7eScmruivwnA==
Date:   Tue, 26 Apr 2022 09:16:02 +0300
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
Subject: Re: [PATCH v7 8/8] drivers/node: Show in sysfs node's crypto
 capabilities
Message-ID: <YmeOIrINQAN1aZhu@kernel.org>
References: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
 <20220425171526.44925-9-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425171526.44925-9-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 02:15:26PM -0300, Martin Fernandez wrote:
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
> index 000000000000..5fd5dc7fc2eb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-node
> @@ -0,0 +1,10 @@
> +What:		/sys/devices/system/node/nodeX/crypto_capable
> +Date:		April 2022
> +Contact:	Martin Fernandez <martin.fernandez@eclypsium.com>
> +Users:		fwupd (https://fwupd.org)
> +Description:
> +		This value is 1 if all system memory in this node is
> +		marked with EFI_MEMORY_CPU_CRYPTO, indicating that the
> +		system memory is capable of being protected with the
> +		CPU’s memory cryptographic capabilities. It is 0
> +		otherwise.

I understand that currently this feature is only for x86, but if non-EFI
architectures will start using MEMBLOCK_CRYPTO_CAPABLE, the sysfs attribute
for will be relevant form them as well.

How about
	This value is 1 if all system memory in this node is capable of
	being protected with the CPU's memory cryptographic capabilities.
	It is 0 otherwise.
	On EFI systems the node will be marked with EFI_MEMORY_CPU_CRYPTO.

> \ No newline at end of file
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index ec8bb24a5a22..1df15ea03c27 100644
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
