Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3F179213
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 15:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbgCDOMG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 09:12:06 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:37698 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725795AbgCDOMG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 09:12:06 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Wed,  4 Mar 2020 14:11:19 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 4 Mar 2020 14:07:34 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 4 Mar 2020 14:07:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bam9isu5dqi07lhhY1tbfG1koEZuNhmW9Is1LRGPXe3HMGHbgYp1wUdHo/70EzvF2IeqKojXPtKUzTl6hKrItmUvR23YCgMbb00vGBvd86r5vcHN8b7Q1ZhVzqW3VRKknktQE3vwo+9r4cuRzULO7IAzcvOTTDLJJ1zXjXhdImSdyDWBv+2nYMehYLEvQLpb8bEY434Fy7DATdmhO7k4Ypjmf6iNF2MsMjREh6XjlF6/jsqXS5WNeFrMWt0fxuA4EASQI+9phE2aWbFSid9XfvCPsswg8VW7WCfquuhumdVsCmSW95Z/53MA2mm6j06YjOXb4sQscxLK/xDFAjsIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqocRL0WblO1XjvmBVAavXv52+WG/HUG5IErsKmxXK4=;
 b=eyIBs99qPtqxi90vAo3+M2vJR67LFF8yHAMycUClQL9T67TSnEYM4Qxs1GHUwh/RVHtP5BkgF89+rLDq3O+dw3OJ3kpK1tmvFFQu/VzozvGd5kZlNHiOjNXpl8jmorJFw6zE3+VRg0x0AfcRXxQDpibrjE1RAiTtAcqdsPfhNrx9+mo9GORHLLlwEDOWeGBFCT7bSNroHUTsrplgj1eeY/6/d3jmioa3DulzlSOuR9enwclHA+OAXFzzHDYS6tmxJLZAY/JQsMrOzMaIR/dxwRx6Uys2yuVz2XTArqBU/Vk89Q4VHshmGpfG/jHb5vK2O5qb5t1O6r9N0vVNSMhEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=JLee@suse.com; 
Received: from CH2PR18MB3240.namprd18.prod.outlook.com (2603:10b6:610:2d::27)
 by CH2PR18MB3143.namprd18.prod.outlook.com (2603:10b6:610:16::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 14:07:32 +0000
Received: from CH2PR18MB3240.namprd18.prod.outlook.com
 ([fe80::b4b0:7004:b49e:a63]) by CH2PR18MB3240.namprd18.prod.outlook.com
 ([fe80::b4b0:7004:b49e:a63%6]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 14:07:32 +0000
Date:   Wed, 4 Mar 2020 22:07:20 +0800
From:   joeyli <jlee@suse.com>
To:     Vladis Dronov <vdronov@redhat.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
Message-ID: <20200304140720.GQ16878@linux-l9pv.suse>
References: <20200303085528.27658-1-vdronov@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200303085528.27658-1-vdronov@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HKAPR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:d0::26) To CH2PR18MB3240.namprd18.prod.outlook.com
 (2603:10b6:610:2d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (124.11.22.254) by HKAPR04CA0016.apcprd04.prod.outlook.com (2603:1096:203:d0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Wed, 4 Mar 2020 14:07:29 +0000
X-Originating-IP: [124.11.22.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f960ad8-47c5-4b4b-6886-08d7c0456143
X-MS-TrafficTypeDiagnostic: CH2PR18MB3143:
X-Microsoft-Antispam-PRVS: <CH2PR18MB3143EB8963C5E3FAC61866A5A3E50@CH2PR18MB3143.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(6506007)(956004)(66946007)(2906002)(6666004)(33656002)(8936002)(30864003)(81156014)(52116002)(81166006)(8676002)(7696005)(5660300002)(36756003)(8886007)(66476007)(186003)(1076003)(66556008)(16526019)(26005)(6916009)(316002)(478600001)(4326008)(86362001)(9686003)(55016002)(43062003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3143;H:CH2PR18MB3240.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Gdp+ufmJ8cmaA1ZdXHA8UlI1FsAKW1IoWGCWwZxFrvtlb+WTErA172n1mig+rz5Efc6fn5g8lNro/Z8VvUDNRzvht4kdZ/laZR+IEWaYd7ehNEhGfX8wWMA0E/TuXB9fD3F0oLNlz54jRw44/64AyQyjx+OBieejEhVQde4lHYwWTOKJA2QDM3r38WP+CmbtR8juEml61ZQmG4M0fBRmy1YbBkn3PoNFIIqiI0dnaVLhvCe0y66GRbcllg2NnyjFZrqcdH5V4FgIj4ru7gi4sokw8xoasetZmGmOxOe9HI2A6i4mL9VHRK3JdWxe2B7cpULBYTsMiNZyGqAF/9fCjrWhYucebyXrXFwkgYh5nF82KJHzYKnV6eHZfrlPDQOUOReVFdflyiRZcP7lFNGQ4SQtMWddWyMjri2TNC5Yzopk2jOnXZONhE80zavs+maxY24+maGuRvJ/0jIXm76V5UMBlArFOaPLdBhRXKW6WGzE7SkKB5hFGgLNae+Jq8f
X-MS-Exchange-AntiSpam-MessageData: 52SQHUrb/TCrbLu0WUOhiFFUCCkXWYw6U4Lx48SFiJL8E6q3xsvBeFrg57in1lhuTmDh8VxySVbrt6BsdB3HvVsi2UQuXdl0sv6pLOdopdztnE0+rh7RrhWKVwowXrmS2YfhIROtnkCsDnwgmwp6+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f960ad8-47c5-4b4b-6886-08d7c0456143
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 14:07:32.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKBSYSic8r9jaPhStmA4lIthxQFhczzjweJ0/vn1r6B+1TwV8vnBYxucGtWAQax4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3143
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Vladis,

On Tue, Mar 03, 2020 at 09:55:28AM +0100, Vladis Dronov wrote:
> There is a race and a buffer overflow corrupting a kernel memory while
> reading an efi variable with a size more than 1024 bytes via the older
> sysfs method. This happens because accessing struct efi_variable in
> efivar_{attr,size,data}_read() and friends is not protected from
> a concurrent access leading to a kernel memory corruption and, at best,
> to a crash. The race scenario is the following:
> 
> CPU0:                                CPU1:
> efivar_attr_read()
>   var->DataSize = 1024;
>   efivar_entry_get(... &var->DataSize)
>     down_interruptible(&efivars_lock)
>                                      efivar_attr_read() // same efi var
>                                        var->DataSize = 1024;
>                                        efivar_entry_get(... &var->DataSize)
>                                          down_interruptible(&efivars_lock)
>     virt_efi_get_variable()
>     // returns EFI_BUFFER_TOO_SMALL but
>     // var->DataSize is set to a real
>     // var size more than 1024 bytes
>     up(&efivars_lock)
>                                          virt_efi_get_variable()
>                                          // called with var->DataSize set
>                                          // to a real var size, returns
>                                          // successfully and overwrites
>                                          // a 1024-bytes kernel buffer
>                                          up(&efivars_lock)
> 
> This can be reproduced by concurrent reading of an efi variable which size
> is more than 1024 bytes:
> 
> ts# for cpu in $(seq 0 $(nproc --ignore=1)); do ( taskset -c $cpu \
> cat /sys/firmware/efi/vars/KEKDefault*/size & ) ; done
> 
> Fix this by protecting struct efi_variable access by efivars_lock by using
> efivar_entry_iter_begin()/efivar_entry_iter_end(). Brush up and unify
> efivar_entry_[gs]et() and __efivar_entry_[gs]et() for this. This looks
> simpler than introducing a separate lock for every struct efi_variable.
> 
> Also fix the same race in efivar_store_raw() and efivar_show_raw(). The
> call in efi_pstore_read_func() is protected like this already.
> 
> Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>

I have reviewed and tested this patch. It's good to me if we still want
to use efi_variable structure as the return buffer of UEFI get/set_variable
protocols.

Please feel free to add:

Reviewed-by: Joey Lee <jlee@suse.com> 

Regards
Joey Lee

> ---
>  drivers/firmware/efi/efi-pstore.c |  2 +-
>  drivers/firmware/efi/efivars.c    | 72 ++++++++++++++++++++++++-------
>  drivers/firmware/efi/vars.c       | 47 ++++++++++++--------
>  include/linux/efi.h               |  2 +
>  4 files changed, 90 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index 9ea13e8d12ec..e4767a7ce973 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -161,7 +161,7 @@ static int efi_pstore_scan_sysfs_exit(struct efivar_entry *pos,
>   *
>   * @record: pstore record to pass to callback
>   *
> - * You MUST call efivar_enter_iter_begin() before this function, and
> + * You MUST call efivar_entry_iter_begin() before this function, and
>   * efivar_entry_iter_end() afterwards.
>   *
>   */
> diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
> index 7576450c8254..f415cf863ee0 100644
> --- a/drivers/firmware/efi/efivars.c
> +++ b/drivers/firmware/efi/efivars.c
> @@ -88,9 +88,15 @@ efivar_attr_read(struct efivar_entry *entry, char *buf)
>  	if (!entry || !buf)
>  		return -EINVAL;
>  
> +	if (efivar_entry_iter_begin())
> +		return -EINTR;
> +
>  	var->DataSize = 1024;
> -	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
> +	if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> +			var->Data)) {
> +		efivar_entry_iter_end();
>  		return -EIO;
> +	}
>  
>  	if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
>  		str += sprintf(str, "EFI_VARIABLE_NON_VOLATILE\n");
> @@ -109,6 +115,8 @@ efivar_attr_read(struct efivar_entry *entry, char *buf)
>  			"EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS\n");
>  	if (var->Attributes & EFI_VARIABLE_APPEND_WRITE)
>  		str += sprintf(str, "EFI_VARIABLE_APPEND_WRITE\n");
> +
> +	efivar_entry_iter_end();
>  	return str - buf;
>  }
>  
> @@ -121,11 +129,19 @@ efivar_size_read(struct efivar_entry *entry, char *buf)
>  	if (!entry || !buf)
>  		return -EINVAL;
>  
> +	if (efivar_entry_iter_begin())
> +		return -EINTR;
> +
>  	var->DataSize = 1024;
> -	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
> +	if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> +			var->Data)) {
> +		efivar_entry_iter_end();
>  		return -EIO;
> +	}
>  
>  	str += sprintf(str, "0x%lx\n", var->DataSize);
> +
> +	efivar_entry_iter_end();
>  	return str - buf;
>  }
>  
> @@ -137,11 +153,19 @@ efivar_data_read(struct efivar_entry *entry, char *buf)
>  	if (!entry || !buf)
>  		return -EINVAL;
>  
> +	if (efivar_entry_iter_begin())
> +		return -EINTR;
> +
>  	var->DataSize = 1024;
> -	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
> +	if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> +			var->Data)) {
> +		efivar_entry_iter_end();
>  		return -EIO;
> +	}
>  
>  	memcpy(buf, var->Data, var->DataSize);
> +
> +	efivar_entry_iter_end();
>  	return var->DataSize;
>  }
>  
> @@ -197,13 +221,21 @@ efivar_store_raw(struct efivar_entry *entry, const char *buf, size_t count)
>  	efi_guid_t vendor;
>  	u32 attributes;
>  	u8 *data;
> -	int err;
> +	int err = 0;
> +
> +	if (!entry || !buf)
> +		return -EINVAL;
> +
> +	if (efivar_entry_iter_begin())
> +		return -EINTR;
>  
>  	if (in_compat_syscall()) {
>  		struct compat_efi_variable *compat;
>  
> -		if (count != sizeof(*compat))
> -			return -EINVAL;
> +		if (count != sizeof(*compat)) {
> +			err = -EINVAL;
> +			goto out;
> +		}
>  
>  		compat = (struct compat_efi_variable *)buf;
>  		attributes = compat->Attributes;
> @@ -214,12 +246,14 @@ efivar_store_raw(struct efivar_entry *entry, const char *buf, size_t count)
>  
>  		err = sanity_check(var, name, vendor, size, attributes, data);
>  		if (err)
> -			return err;
> +			goto out;
>  
>  		copy_out_compat(&entry->var, compat);
>  	} else {
> -		if (count != sizeof(struct efi_variable))
> -			return -EINVAL;
> +		if (count != sizeof(struct efi_variable)) {
> +			err = -EINVAL;
> +			goto out;
> +		}
>  
>  		new_var = (struct efi_variable *)buf;
>  
> @@ -231,18 +265,20 @@ efivar_store_raw(struct efivar_entry *entry, const char *buf, size_t count)
>  
>  		err = sanity_check(var, name, vendor, size, attributes, data);
>  		if (err)
> -			return err;
> +			goto out;
>  
>  		memcpy(&entry->var, new_var, count);
>  	}
>  
> -	err = efivar_entry_set(entry, attributes, size, data, NULL);
> +	err = __efivar_entry_set(entry, attributes, size, data, NULL);
>  	if (err) {
>  		printk(KERN_WARNING "efivars: set_variable() failed: status=%d\n", err);
> -		return -EIO;
> +		err = -EIO;
>  	}
>  
> -	return count;
> +out:
> +	efivar_entry_iter_end();
> +	return err ?: count;
>  }
>  
>  static ssize_t
> @@ -255,10 +291,15 @@ efivar_show_raw(struct efivar_entry *entry, char *buf)
>  	if (!entry || !buf)
>  		return 0;
>  
> +	if (efivar_entry_iter_begin())
> +		return -EINTR;
> +
>  	var->DataSize = 1024;
> -	if (efivar_entry_get(entry, &entry->var.Attributes,
> -			     &entry->var.DataSize, entry->var.Data))
> +	if (__efivar_entry_get(entry, &var->Attributes, &var->DataSize,
> +			var->Data)) {
> +		efivar_entry_iter_end();
>  		return -EIO;
> +	}
>  
>  	if (in_compat_syscall()) {
>  		compat = (struct compat_efi_variable *)buf;
> @@ -276,6 +317,7 @@ efivar_show_raw(struct efivar_entry *entry, char *buf)
>  		memcpy(buf, var, size);
>  	}
>  
> +	efivar_entry_iter_end();
>  	return size;
>  }
>  
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 436d1776bc7b..4a47e20a7667 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -636,7 +636,7 @@ int efivar_entry_delete(struct efivar_entry *entry)
>  EXPORT_SYMBOL_GPL(efivar_entry_delete);
>  
>  /**
> - * efivar_entry_set - call set_variable()
> + * __efivar_entry_set - call set_variable()
>   * @entry: entry containing the EFI variable to write
>   * @attributes: variable attributes
>   * @size: size of @data buffer
> @@ -655,8 +655,12 @@ EXPORT_SYMBOL_GPL(efivar_entry_delete);
>   * Returns 0 on success, -EINTR if we can't grab the semaphore,
>   * -EEXIST if a lookup is performed and the entry already exists on
>   * the list, or a converted EFI status code if set_variable() fails.
> + *
> + * The caller MUST call efivar_entry_iter_begin() and
> + * efivar_entry_iter_end() before and after the invocation of this
> + * function, respectively.
>   */
> -int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
> +int __efivar_entry_set(struct efivar_entry *entry, u32 attributes,
>  		     unsigned long size, void *data, struct list_head *head)
>  {
>  	const struct efivar_operations *ops;
> @@ -664,9 +668,6 @@ int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
>  	efi_char16_t *name = entry->var.VariableName;
>  	efi_guid_t vendor = entry->var.VendorGuid;
>  
> -	if (down_interruptible(&efivars_lock))
> -		return -EINTR;
> -
>  	if (!__efivars) {
>  		up(&efivars_lock);
>  		return -EINVAL;
> @@ -682,10 +683,28 @@ int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
>  		status = ops->set_variable(name, &vendor,
>  					   attributes, size, data);
>  
> -	up(&efivars_lock);
> -
>  	return efi_status_to_err(status);
> +}
> +EXPORT_SYMBOL_GPL(__efivar_entry_set);
>  
> +/**
> + * efivar_entry_set - call set_variable()
> + *
> + * This function takes efivars_lock and calls __efivar_entry_set()
> + */
> +int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
> +		     unsigned long size, void *data, struct list_head *head)
> +{
> +	int ret;
> +
> +	if (down_interruptible(&efivars_lock))
> +		return -EINTR;
> +
> +	ret = __efivar_entry_set(entry, attributes, size, data, head);
> +
> +	up(&efivars_lock);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(efivar_entry_set);
>  
> @@ -914,22 +933,16 @@ EXPORT_SYMBOL_GPL(__efivar_entry_get);
>  int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
>  		     unsigned long *size, void *data)
>  {
> -	efi_status_t status;
> +	int ret;
>  
>  	if (down_interruptible(&efivars_lock))
>  		return -EINTR;
>  
> -	if (!__efivars) {
> -		up(&efivars_lock);
> -		return -EINVAL;
> -	}
> +	ret = __efivar_entry_get(entry, attributes, size, data);
>  
> -	status = __efivars->ops->get_variable(entry->var.VariableName,
> -					      &entry->var.VendorGuid,
> -					      attributes, size, data);
>  	up(&efivars_lock);
>  
> -	return efi_status_to_err(status);
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(efivar_entry_get);
>  
> @@ -1071,7 +1084,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
>   * entry on the list. It is safe for @func to remove entries in the
>   * list via efivar_entry_delete().
>   *
> - * You MUST call efivar_enter_iter_begin() before this function, and
> + * You MUST call efivar_entry_iter_begin() before this function, and
>   * efivar_entry_iter_end() afterwards.
>   *
>   * It is possible to begin iteration from an arbitrary entry within
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 7efd7072cca5..5c3db088d375 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1414,6 +1414,8 @@ int __efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
>  		       unsigned long *size, void *data);
>  int efivar_entry_get(struct efivar_entry *entry, u32 *attributes,
>  		     unsigned long *size, void *data);
> +int __efivar_entry_set(struct efivar_entry *entry, u32 attributes,
> +		     unsigned long size, void *data, struct list_head *head);
>  int efivar_entry_set(struct efivar_entry *entry, u32 attributes,
>  		     unsigned long size, void *data, struct list_head *head);
>  int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
> -- 
> 2.20.1
