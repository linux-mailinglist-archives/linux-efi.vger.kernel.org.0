Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A0A17868A
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 00:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgCCXkV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Mar 2020 18:40:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40124 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgCCXkV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Mar 2020 18:40:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id o10so31985qtr.7
        for <linux-efi@vger.kernel.org>; Tue, 03 Mar 2020 15:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fF63PTGaptVX8qwSKQHVhiM3NGTtgmUaKxEtHZyvk/8=;
        b=blJwV2Jq00d/TIw7HVIfLIgRSqEeJ3A0qmbmvy2Vk1ix2/LT+mWWdvhoC0XqtcLKLr
         Gpu7tSQzSofn7TNIN1SCb1uSzXTIMHF408H+mAOrU4BZWUVxgUZ2HLk1ZbEMfWjX/c96
         2WIyr7fbzPsOEbbeUoUNQ3cPnwDPHQ5rXEeCQgwaU6eWACz8fpcW05frFloA7A+S21gU
         JxW2+Qmi3XUr7EkQQ6BQDbCRfzqeJSuJ8JHbqVmY7k9i+CTovoM+OEoZNCLvdTDy2+8m
         q8aS/03b0cKjheH6vOjJxTyrk26KeLI2NzLF3q7eEiHqQXKws26I0Zl2dQZh9qNRF3/k
         Sn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=fF63PTGaptVX8qwSKQHVhiM3NGTtgmUaKxEtHZyvk/8=;
        b=dZJWSDQiRWrQC1DhXVLj7O5Yg2rdiTBCQ1dJg81YkvrlA0UUUS0XTw+gajqvfu5Ezl
         yKFr6LrFlAFSfh0OuCLMKrPbL6s5P1d9/C9h5X7AecPrFuNDM/HsHQUgVgkP0xSDF3eF
         0qyWRPEU1YQ/WQyiVkGOAhKak/STdlAkGSXBgorB6bz1gpRej/I7GZK8LDNSsh+OSq3F
         686HY7gESyFE45pfX6hbZm+JGGaHdn9THLlfqaWmBHBJ3tsxp/d33Ys0QUwVkSdEPY+x
         fbfk4GdyUDN/q0JZX1W0w83FGyC1aZ4qQlPrua+A3soFTpLgDxD0w+/hetR3YZncSHP4
         F4vQ==
X-Gm-Message-State: ANhLgQ1QrgFXZK3dd/raBhCLWa4S+S2mNElnCelUSlTh8swi2TBOZela
        /+IvrlkNG8fjLg+FOPio6Xv894OAshg=
X-Google-Smtp-Source: ADFU+vt1rFGG3NPSCiV4+bwXzAzLxUiq9O80AYDmnib7SaMeJ+F1pJxY6tyxFTQm0HvP7joIlXNN1Q==
X-Received: by 2002:ac8:4e94:: with SMTP id 20mr46264qtp.335.1583278820050;
        Tue, 03 Mar 2020 15:40:20 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o6sm2286966qkj.96.2020.03.03.15.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 15:40:19 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 3 Mar 2020 18:40:18 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: ioremap WARN on 32-bit kernel
Message-ID: <20200303234018.GB154112@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I consistently get this splat when booting 32-bit kernel on QEMU+OVMF,
with at least 1024Mb. Seems to have been there for quite a while (before
v5.0). Any ideas/can you repro?

[    0.227718] ------------[ cut here ]------------                                                                                                                                                                                                                            
[    0.227998] ioremap on RAM at 0x3f251000 - 0x3fa1afff                                                                                                                                                                                                                       
[    0.228421] WARNING: CPU: 0 PID: 0 at arch/x86/mm/ioremap.c:166 __ioremap_caller.constprop.0+0x249/0x260                                                                                                                                                                    
[    0.228570] Modules linked in:                                                                                                                                                                                                                                              
[    0.228570] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0 #48                                                                                                                                                                                                            
[    0.228570] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015                                                                                                                                                                                    
[    0.228570] EIP: __ioremap_caller.constprop.0+0x249/0x260                                                                                                                                                                                                                   
[    0.228570] Code: 90 0f b7 05 4e 38 40 de 09 45 e0 e9 09 ff ff ff 90 8d 45 ec c6 05 a1 52 4a de 01 50 8d 45 e4 50 68 b4 7b 2d de e8 3e bb 00 00 <0f> 0b 31 ff 83 c4 0c e9 66 ff ff ff 8d b4 26 00 00 00 00 8d 74 26                                                         
[    0.228570] EAX: 00000029 EBX: 00000000 ECX: de59c228 EDX: 00000001                                                                                                                                                                                                         
[    0.228570] ESI: 3f250fff EDI: 00000000 EBP: de3edf20 ESP: de3edee0                                                                                                                                                                                                         
[    0.228570] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00200296                                                                                                                                                                                                   
[    0.228570] CR0: 80050033 CR2: ffd17000 CR3: 1e58c000 CR4: 00040690                                                                                                                                                                                                         
[    0.228570] Call Trace:                                                                                                                                                                                                                                                     
[    0.228570]  ioremap_cache+0xd/0x10                                                                                                                                                                                                                                         
[    0.228570]  ? old_map_region+0x72/0x9d                                                                                                                                                                                                                                     
[    0.228570]  old_map_region+0x72/0x9d                                                                                                                                                                                                                                       
[    0.228570]  efi_map_region+0x8/0xa                                                                                                                                                                                                                                         
[    0.228570]  efi_enter_virtual_mode+0x260/0x43b                                                                                                                                                                                                                             
[    0.228570]  start_kernel+0x329/0x3aa                                                                                                                                                                                                                                       
[    0.228570]  i386_start_kernel+0xa7/0xab                                                                                                                                                                                                                                    
[    0.228570]  startup_32_smp+0x164/0x168                                                                                                                                                                                                                                     
[    0.228570] ---[ end trace e15ccf6b9f356833 ]---
