Return-Path: <linux-efi+bounces-1931-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED90A997024
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641CFB21403
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206F31E132D;
	Wed,  9 Oct 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A83G9bvs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A321E130B;
	Wed,  9 Oct 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487789; cv=none; b=jhT+nT5uhRXBV9AM3yTmhZso0Hj8F6Tpef4V6uMVrNaDn8AwARI7/GKRGcrDRP8HwLALv0XtB8SfJsSk9Apk42g9jd97JSVEzjICJ8g7fj1Z41UJcAAg0giIae2hFK1jfheQm0PCp1AgOdw818U4ypXmZ3HaEpLJbHiZ/yEbNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487789; c=relaxed/simple;
	bh=ZtT7UFjN7sSz37fKqb+t/akf5kJpBSeCTf8zygepQH0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rV6vN0Jf+bh8gj2LFsvpsmXwXt74YXCAAsb8scERb52dst+Kk5MH9iz6wnLWnV0GcnFgmIRJczZCT4NxUQrkmZgTqqH0GROT0yWH2ZI46RGzYM44R5llauCzYby+Z5MZilvqcc6aFLQuOFYI83s56Kx/B3TJHVHT4XiFXbQ+Hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A83G9bvs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c90333aaf1so1907164a12.0;
        Wed, 09 Oct 2024 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728487785; x=1729092585; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT6jVMODo/HMO0UIFUfJLKxwS7jYhZy5AYmxdNnRHSY=;
        b=A83G9bvsLkA9QATGde82HK93ivTEI8v8y0JRlGrfde5i1TyHDfSreuYK+nDqoY/G2U
         N8pTIvS1xKXp9o7tfTbxhSLPpW2bFM4vMLlYUC/gm5sGr5aGX2qXeFxNGX1PlgctOUm7
         E6+kQUpfwLCt8gGuzF6xlBat5eU90D89PIpcas2SDh6HU9a//MVyUkOZpylizSw1PrgQ
         /dOaFJxbtT9em1ITwlvRrIfWagqRXdZGQf5Z7G3wH//b2RXW4y9zXBEvy2mzn7DmaQ+Y
         uvSuB6fD0C5TWtdm4ju4dyMmqy5NYyimnq7KlIMG8XAU/PbbSTCTx0GB3iGMkD5Lje5X
         Ytqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728487785; x=1729092585;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PT6jVMODo/HMO0UIFUfJLKxwS7jYhZy5AYmxdNnRHSY=;
        b=OuR7wL48rxc9v4RBlbb0hBIaqn/S6zaB8YQI4sU3r+9zGgimz1lmOWocZJV+LOeDkt
         OHC6BFj+sYlUxaCTFW219hKUQR3qdWYPqmNRxZE9ufLJBhaZ5XPe/DsFCb7x3+gHmHdX
         1J25M56OAagcXum3XfKqoLizEsV0MMpGYwuaRJQy4BUsKKLNhMhHqN/JM8shbtnveiBN
         2+EOud5tjRPm2Guk8MJXWTMw4r+EgceGeibTSXvUHx2I7wKmFCKMeJbVPhszCN+dSM6i
         G++0beJHjvfI7xkdtsBQ6eXA3JXvQeuOn7xzm9vHA0ZXqlT7CxPwZx9XOq0pkPgSqduG
         ptfw==
X-Forwarded-Encrypted: i=1; AJvYcCWhIOpyL569TycRhSxuJ8JDUkPEFt5dMLSJe/FKq1JdITHNmvn+mCYRJiYhZtfYJCnyKrXEKxyPe1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcctQFisS2IZ+sRzigdCS+Trz6YN5VIZ7M+jpmNXUUPWfeerw
	HnKz0kFPQDlDBvfu9iQr0Kkyr/MB8CaMauMIT13A1CcdcoGk5M76Va+7MQ==
X-Google-Smtp-Source: AGHT+IGyQgt2jTtrAqGbCO4hFzkgwlKKqoxUk2fEUsykuESdSEgYPpjl212JJJ/+9IounoHx59SLSg==
X-Received: by 2002:a05:6402:c43:b0:5c8:8290:47bf with SMTP id 4fb4d7f45d1cf-5c91d5b3771mr2861298a12.21.1728487784764;
        Wed, 09 Oct 2024 08:29:44 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:10fe])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c914d785b8sm1543634a12.30.2024.10.09.08.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:29:44 -0700 (PDT)
Message-ID: <c4da3a99-2e9d-4461-a429-f07a7deaf8f1@gmail.com>
Date: Wed, 9 Oct 2024 16:29:43 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
 devel@edk2.groups.io, linux-efi@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>, noodles@earth.li,
 Gregory Price <gourry@gourry.net>, peterhuewe@gmx.de, jarkko@kernel.org,
 jgg@ziepe.ca, arnd@arndb.de, Ard Biesheuvel <ardb@kernel.org>,
 tweek@google.com, leendert@watson.ibm.com, kjhall@us.ibm.com
From: Usama Arif <usamaarif642@gmail.com>
Subject: Possible overflow of TPM log
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

We (meta) are seeing the below warning in production machines for all kernels from 5.12 to 6.11 during boot which results in tpm probe failing:


[    6.388599] ------------[ cut here ]------------                                                                                                                                                                                                                                                                          
[    6.397804] memremap attempted on mixed range 0x000000005f54e018 size: 0x23ba3cfb                                                                                                                                                                                                                                         
[    6.412733] WARNING: CPU: 2 PID: 1 at kernel/iomem.c:82 memremap+0x58/0x1b0                                                                                                                                                                                                                                               
[    6.426621] Modules linked in:                                                                                                                                                                                                                                                                                            
[    6.432705] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.4.3-0_fbk12_2624_g7d95a0297d81 #1                                                                                                                                                                                                                                 
[    6.449020] Hardware name: Quanta Twin Lakes MP/Twin Lakes Passive MP, BIOS F09_3A23 12/08/2020                                                                                                                                                                                                                           
[    6.466377] RIP: 0010:memremap+0x58/0x1b0                                                                                                                                                                                                                                                                                 
[    6.474369] Code: 41 89 c4 83 f8 02 75 26 80 3d fc 33 66 01 00 75 57 c6 05 f3 33 66 01 01 48 89 e6 48 c7 c7 3b 98 34 82 4c 89 f2 e8 38 96 bc ff <0f> 0b eb 3a 41 f6 c7 01 75 04 31 db eb 13 45 85 e4 74 69 48 89 ef                                                                                                       
[    6.511837] RSP: 0000:ffffc900000378f8 EFLAGS: 00010286                                                                                                                                                                                                                                                                   
[    6.522258] RAX: 0000000000000045 RBX: 0000000000000000 RCX: ffffffff82c5fdb8                                                                                                                                                                                                                                             
[    6.536490] RDX: 0000000000000000 RSI: c0000000fffeffff RDI: 000000000000ffff                                                                                                                                                                                                                                             
[    6.550723] RBP: 000000005f54e018 R08: ffffffff82de0190 R09: 0000000000000000                                                                                                                                                                                                                                             
[    6.564956] R10: ffffffff82c5fde0 R11: 3fffffffffffffff R12: 0000000000000002                                                                                                                                                                                                                                             
[    6.579187] R13: 0000000000000000 R14: 0000000023ba3cfb R15: 0000000000000001                                                                                                                                                                                                                                             
[    6.593421] FS:  0000000000000000(0000) GS:ffff88903f880000(0000) knlGS:0000000000000000                                                                                                                                                                                                                                  
[    6.609559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                                                                                                                                                                                                                                                             
[    6.621026] CR2: 0000000000000000 CR3: 0000000062c0a001 CR4: 00000000007706e0                                                                                                                                                                                                                                             
[    6.635257] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000                                                                                                                                                                                                                                             
[    6.649489] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400                                                                                                                                                                                                                                             
[    6.663724] PKRU: 55555554                                                                                                                                                                                                                                                                                                
[    6.669115] Call Trace:                                                     
[    6.673986]  <TASK>                                                         
[    6.678162]  ? __warn+0x9f/0x130                                            
[    6.684595]  ? memremap+0x58/0x1b0                                          
[    6.691371]  ? report_bug+0xcc/0x150                                        
[    6.698499]  ? handle_bug+0x3d/0x70                                         
[    6.705449]  ? exc_invalid_op+0x16/0x40                                     
[    6.713093]  ? asm_exc_invalid_op+0x16/0x20                                 
[    6.721433]  ? memremap+0x58/0x1b0                                          
[    6.728211]  ? memremap+0x58/0x1b0                                          
[    6.732866] Freeing initrd memory: 51140K                                   
[    6.734986]  tpm_read_log_efi+0x7d/0x1e0                                    
[    6.750795]  tpm_bios_log_setup+0x51/0x170                                  
[    6.758959]  tpm_chip_register+0x36/0x220                                   
[    6.766948]  tpm_tis_core_init+0x438/0x630                                  
[    6.775112]  tpm_tis_init+0x103/0x190                                       
[    6.782410]  tpm_tis_plat_probe+0x87/0x90                                   
[    6.790401]  platform_probe+0x2f/0x60                                       
[    6.797705]  really_probe+0x1ec/0x340                                       
[    6.805002]  driver_probe_device+0x1e/0x80                                  
[    6.813184]  __driver_attach+0x10e/0x1a0                                    
[    6.821018]  ? driver_attach+0x20/0x20                                      
[    6.828491]  bus_for_each_dev+0x64/0xa0                                     
[    6.836136]  bus_add_driver+0x196/0x210                                     
[    6.843781]  ? __initstub__kmod_tpm__370_527_tpm_init4+0x100/0x100                                                                                         
[    6.856109]  driver_register+0x5e/0xf0                                      
[    6.863580]  __initstub__kmod_tpm_tis__319_478_init_tis6+0x7f/0xc0                                                                                         
[    6.875908]  ? add_device_randomness+0x62/0x70                              
[    6.884768]  do_one_initcall+0xad/0x1f0                                     
[    6.892414]  ? alloc_pages+0x120/0x2c0                                      
[    6.899885]  ? security_kernfs_init_security+0x2a/0x40                      
[    6.910132]  ? idr_alloc_cyclic+0xaa/0x110                                  
[    6.918295]  ? idr_alloc_cyclic+0xaa/0x110                                  
[    6.926458]  ? alloc_pages+0x15c/0x2c0                                      
[    6.933928]  ? number+0x1da/0x400                                           
[    6.940531]  ? ida_alloc_range+0x193/0x410                                  
[    6.948696]  ? parse_args+0x14b/0x380                                       
[    6.955996]  kernel_init_freeable+0x1b1/0x2a0                               
[    6.964682]  ? rest_init+0xb0/0xb0                                          
[    6.971461]  kernel_init+0x16/0x1a0                                         
[    6.978410]  ret_from_fork+0x1f/0x30                                        
[    6.985536]  </TASK>                                                        
[    6.989885] ---[ end trace 0000000000000000 ]---                            
[    6.999089] Could not map UEFI TPM log table payload!   


The memremap being attempted is from 0x5f54e018 to 0x830f1d13, which looking at /proc/iomem, is overlapping all the below regions.

cat /proc/iomem
...
  61000000-61ffffff : Kernel code
  62000000-62bf4fff : Kernel rodata
  62c00000-634e28bf : Kernel data
  63b8e000-641fffff : Kernel bss
64dbb000-64dbbfff : Reserved
64dbc000-69c89fff : System RAM
69c8a000-6bd89fff : Reserved
  6ad6d018-6ad6d027 : APEI EINJ
  6ad6d048-6ad6d067 : APEI EINJ
  6ad6d078-6ad6d07f : APEI EINJ
  6ad6e018-6ad6e018 : APEI ERST
  6ad6e01c-6ad6e021 : APEI ERST
  6ad6e028-6ad6e039 : APEI ERST
  6ad6e040-6ad6e04c : APEI ERST
  6ad6e050-6ad7004f : APEI ERST
6bd8a000-6be44fff : ACPI Tables
6be45000-6c99efff : ACPI Non-volatile Storage
6c99f000-6ebedfff : Reserved
6ebee000-6fffffff : System RAM
70000000-7fffffff : Reserved
80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
...

The kernel is being booted using kexec. 0x23ba3cfb is 571MB which looks too big. Could it be that the log size grew too big in the previous kernel? Or is it a memory corruption similar to the issue we encountered in [1] and solved in [2]?

[1] https://lore.kernel.org/all/20240910-juicy-festive-sambar-9ad23a@devvm32600/
[2] https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/

Thanks!
Usama


