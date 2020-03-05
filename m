Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9C3179FB8
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 07:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgCEGCF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 01:02:05 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:49082 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgCEGCF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Mar 2020 01:02:05 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Thu,  5 Mar 2020 06:01:18 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 5 Mar 2020 06:01:33 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 5 Mar 2020 06:01:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDXDGX5Fe4BfhVWEzpILhWs0mpGPMdFNmuCoRlvWGduzfILBYgXQTy1PkTQp/xSMh4veXwaFrJkiEZsr62/J4LLdjJkAzEKyEZSLsr2VeCZWGxKK4t/wt1O5zysClft1t+lechtgmk4luKpd58Nz58FHRZ0ZX7i5zulGjIzxRA0pXk5zQAZTk2qC8EXoo0BYASHDWaICXuCwdFzQkBab8YsVbVr9PLLbTBlQYSIEqUfHjwDuva/wQ9XtTvSdnU2TifTwedixkCDTxfhMsVWkK6yEVHNNeNZngxzoHfXoAY6cv82xWWgve0mBK6bzUoKZZvoMQZ7YlmaAUtJOv2a7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOpGEYsfcqxWkPNVwmG+AhqHlsg7ttjeZH6KCp/3WPo=;
 b=VuD9GQq/G36YV6gwct6KvyYXMMxSSimdy8WEj8kmHsDnJbF1g+YO/LkQM3slns8DEnhYbwevqCV9k8IVGKF1U2OJAoIuroOsIID+oGeqRx9yab1omy4y7g9H6aWD15uIYosezJVP3fDd9GOJ3xTrG/hoT1QSMkyX67AEWkzVth/Du03V7EHRi9kPZJHr4jjiME3TAbJkQONK1jx7pZhm/SXCFbV360pauoUrrRzbZPo9kdB4Idefyv+q2dokUEqD5ifhM7gmcukAzxeO45Wwfe2f1u6JdgohhzxndYRFrXRyCNfpGTbcl+dbCM7tVguueQASTZ8vsur/7lFRwfu1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=JLee@suse.com; 
Received: from CH2PR18MB3240.namprd18.prod.outlook.com (2603:10b6:610:2d::27)
 by CH2PR18MB3223.namprd18.prod.outlook.com (2603:10b6:610:28::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Thu, 5 Mar
 2020 06:01:32 +0000
Received: from CH2PR18MB3240.namprd18.prod.outlook.com
 ([fe80::b4b0:7004:b49e:a63]) by CH2PR18MB3240.namprd18.prod.outlook.com
 ([fe80::b4b0:7004:b49e:a63%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 06:01:32 +0000
Date:   Thu, 5 Mar 2020 14:01:23 +0800
From:   joeyli <jlee@suse.com>
To:     Vladis Dronov <vdronov@redhat.com>
CC:     Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
Message-ID: <20200305060123.GS16878@linux-l9pv.suse>
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
 <20200304154936.24206-1-vdronov@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200304154936.24206-1-vdronov@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR02CA0205.apcprd02.prod.outlook.com
 (2603:1096:201:20::17) To CH2PR18MB3240.namprd18.prod.outlook.com
 (2603:10b6:610:2d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (60.251.47.115) by HK2PR02CA0205.apcprd02.prod.outlook.com (2603:1096:201:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Thu, 5 Mar 2020 06:01:30 +0000
X-Originating-IP: [60.251.47.115]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 631f20f7-6865-47ce-5a2e-08d7c0caa74b
X-MS-TrafficTypeDiagnostic: CH2PR18MB3223:
X-Microsoft-Antispam-PRVS: <CH2PR18MB3223E6923FEEEE3B5F14F64AA3E20@CH2PR18MB3223.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(2906002)(16526019)(66946007)(6506007)(8886007)(186003)(956004)(478600001)(316002)(4326008)(8936002)(86362001)(52116002)(9686003)(81166006)(66556008)(55236004)(5660300002)(33656002)(6666004)(55016002)(66476007)(81156014)(26005)(7696005)(6916009)(8676002)(1076003)(43062003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR18MB3223;H:CH2PR18MB3240.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1IcXcKeir+dXkS4zyY1mcvLA39exkHYyRbxpuyUhVLcPQlmPDHHEDL3b0M+G+XRZfCaSX0SGBhDuCx7PUusRoJb5OjFLY5TkdVMCUj9t8n2ijgEEDMqnVnAJxtGJiI/aD+JSk3v1VZlVMhDOpfGJqcawteUrrWmnOfRkCCY8vBEr12mQvTg6+VHb9uFXdTmPDJZR+DbQYqRWPd9BzE10Kpakc1nVIecK2Gg7JmFlUQsg72NMdPi2kTYXoe6pKairXApHg3AP4cWksloNdaohqa8JMgZJfPbFWRt+c+hcrg4UKw1T+dphrmp8qJr2rH5IvFAos2Jo5UGwBetCm7upjLJkcIUNDH44qc/1JQCp2jU//mgYWhbEwJLo4wYvsQ3lsv8F8MwDSPMEnrHMPmCQ209iK448/gi3FVo9qZB+8oooTrv59UwztY+rnSM+pYyl2XdYetYGVIHjb/+W5MR6N4/xUp41IBzIXgxGXiYODdCMOloFDDvtmelhDtP3pMwP
X-MS-Exchange-AntiSpam-MessageData: L8e2zfAxQDHAUud9r9+O8vpENVAiFOIBqELdTzy5RvzdMoQ4GY83/PfQ6fGQsWzqIesal77oX6E3P2b7UE39Vm+mjVFHUXD9SBlqu8gTbVia+Wgd/AOhy+86X4pMdZaIcVto8QmAiv3pH3y9wKJcww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 631f20f7-6865-47ce-5a2e-08d7c0caa74b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 06:01:32.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfLorypEMdR8mD2/VGR9PbRvEnWJaGE0+vkaBZ86N9bIZOLZyHHn1zBjvqlVvQWj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3223
X-OriginatorOrg: suse.com
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Vladis,

On Wed, Mar 04, 2020 at 04:49:36PM +0100, Vladis Dronov wrote:
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
> Fix this by using a local variable for a var's data buffer size so it
> does not get overwritten. Also add a sanity check to efivar_store_raw().
> 
> Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  drivers/firmware/efi/efi-pstore.c |  2 +-
>  drivers/firmware/efi/efivars.c    | 32 ++++++++++++++++++++++---------
>  drivers/firmware/efi/vars.c       |  2 +-
>  3 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index 9ea13e8d12ec..e4767a7ce973 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -161,7 +161,7 @@ static int efi_pstore_scan_sysfs_exit(struct efivar_entry *pos,
>   *
>   * @record: pstore record to pass to callback
[...snip]
> @@ -250,14 +262,16 @@ efivar_show_raw(struct efivar_entry *entry, char *buf)
>  {
>  	struct efi_variable *var = &entry->var;
>  	struct compat_efi_variable *compat;
> +	unsigned long datasize = sizeof(var->Data);
>  	size_t size;
> +	int ret;
>  
>  	if (!entry || !buf)
>  		return 0;
>  
> -	var->DataSize = 1024;
> -	if (efivar_entry_get(entry, &entry->var.Attributes,
> -			     &entry->var.DataSize, entry->var.Data))
> +	ret = efivar_entry_get(entry, &var->Attributes, &datasize, var->Data);
> +	var->DataSize = size;

The size is indeterminate here. I think that it should uses datasize?
	var->DataSize = datasize;

> +	if (ret)
>  		return -EIO;
>  
>  	if (in_compat_syscall()) {

Regards
Joey Lee
