Return-Path: <linux-efi+bounces-3494-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF45EAA40AC
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 03:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 280F64A71BF
	for <lists+linux-efi@lfdr.de>; Wed, 30 Apr 2025 01:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616EC78F24;
	Wed, 30 Apr 2025 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="fx82opzQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244762DC79D;
	Wed, 30 Apr 2025 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745977358; cv=pass; b=MHqylSpsLzqU6Kar40yUNumzK3lmFXp2TQfCid5lBsugJ+B4imiB2TXSLskGI3x7jRF5X12qUDkaMVdCHF1CtemjyJwbj25AgX64gZP1FskUXrn9Pd5t9NqywEdPsd5pmcOK3x14+dvtOOh3Tmtg2nrp271TuJ0OqSVY3v1OFzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745977358; c=relaxed/simple;
	bh=80Wce/TJ0EfBaI5XkKuJJomnoqApQfnai9qLRJl/858=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAu1jJWdK3U5uWwk5vgpj2iOhxoNgATZUfrlikHRS+K4Hf5SAtgY1w5ZmLijRQipDIrYhj4YqNJo6zk7UN2dGFFzQ0nCj6FWyUYk26Y/0TqBHCErZvB+IIbbEPCDRVZoCQyHOCXQ2oqzMcx4W9xUn0RcZRUaKJOI/fG9JqYYGqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=fx82opzQ; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1745977259; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cEmMBxndzSVd7OvztmbdX2jTVoT0khc84/CQ1s40YnxLgj7UU/k4K01oAFiHgCyUQnSc5WjzJ4j9t+F+qeicLcCP0FtbfEGMsCMc9XxvpICtI7i9+eEx1jZCn55RA3S0J4kgpPZGucsahl6rXyn1NGDbvwQ2vcGLGHiNGActRh8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745977259; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TJoZQ2p31nLOqEvAJVPjPhI+B+yCxFIzT2smc52XK8s=; 
	b=OZynF2npinIsNyog/tusiKLBgLFWkBnOaDEMXuOnNAlgdcwRrV0qlxq1Z8zpQri/jHzleSxG/OVmHw1d7LSeSeHkRrvpy9jW+QbZBYd0pHUTnr7vaPgto4FvH4s5b4R+Qpadt8yUmcJO6oAltXGT7kBCzmtX9C91uj+OUN/OfSc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745977259;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TJoZQ2p31nLOqEvAJVPjPhI+B+yCxFIzT2smc52XK8s=;
	b=fx82opzQpA21QiQmLU4q/kLJFWcygEgQWdUvve2Q+0jdTPvVEJHnsvkXvpD8EwGJ
	SNixJcvxKAUt2o4YzFkkSG4auJENrnZaNGlVXFPAKD8qCJcZ3+sQMTMGEvkSBqHCHpJ
	wpkZWgeSVqN8o8iEW2EOn96k25y6HmlXzYWVa+Kg=
Received: by mx.zohomail.com with SMTPS id 1745977255108733.3900332082078;
	Tue, 29 Apr 2025 18:40:55 -0700 (PDT)
Message-ID: <077163e1-b7e1-4bc9-8294-e557cc7bd78d@apertussolutions.com>
Date: Tue, 29 Apr 2025 21:40:51 -0400
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 18/19] x86: Secure Launch late initcall platform
 module
Content-Language: en-US
To: Andy Lutomirski <luto@amacapital.net>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-19-ross.philipson@oracle.com>
 <CALCETrVayuzp7fstavHkx99eieUCNj3=Zt8D=WOqMnmeT6DKmQ@mail.gmail.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; keydata=
 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
In-Reply-To: <CALCETrVayuzp7fstavHkx99eieUCNj3=Zt8D=WOqMnmeT6DKmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/28/25 13:38, Andy Lutomirski wrote:
>> On Apr 21, 2025, at 9:36 AM, Ross Philipson <ross.philipson@oracle.com> wrote:
>>
>> ﻿From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> The Secure Launch platform module is a late init module. During the
>> init call, the TPM event log is read and measurements taken in the
>> early boot stub code are located. These measurements are extended
>> into the TPM PCRs using the mainline TPM kernel driver.
> 
> I read through some of the TPM and TXT docs, and I haven’t found a
> clear explanation of exactly what gets hashed into which PCR.  (Mostly
> because the docs are full of TXT-specific terms.)


For Intel TXT, the general approach is detailed in section 1.10.2 of the 
TXT Software Development Guide[1]. I point you at the Detail and 
Authorities Usage section because the ability to do Legacy Usage has 
been unavailable for some time.

In section 1.10.2.1, the dialogue explains how and what the initial 
measurement is into PCR17. After that is Table 1, which provides a 
listing of all the measurements the ACM could make before starting the 
MLE. Just as an FYI, on Gen 9 and later, the STM measurement will be 
present and will be the hash of the PPAM module.[2]

Section 1.10.2.2 gives a similar treatment to PCR18.

[1] 
https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-txt-software-development-guide.pdf
[2] 
https://www.intel.com/content/dam/www/central-libraries/us/en/documents/drtm-based-computing-whitepaper.pdf


> But I’m really struggling to understand how the security model ends up
> being consistent with this late_initcall thing. We measure some state
> into the event log, and then we do a whole bunch of things (everything
> from the very beginning of loading the kernel proper to the whenever
> in the late_initcall stage this code runs), and then we actually
> extend the PCRs.  It seems to me that this may involve a whole lot of
> crossing fingers that an attacker can’t find a way to get the kernel
> to execute code that changes the event log in memory prior to
> extending PCRs such that attacker-controlled values get written.  Even
> if the design is, in principle, sound, the attack surface seems much,
> much larger than it deserves to be.


There is a more fundemental flaw to your scenario, but before covering 
that, consider what measurements could be tampered with that are made by 
the setup kernel:

  - Kernel Setup Data
  - TrenchBoot's SLRT
  - Boot Params
  - Command line
  - EFI Memory Map
  - EFI configuration items, populated by efi-stub (currently unused)
  - External Ramdisk

Outside of the case of an external ramdisk, the attacker can only 
pretend valid configuration data was passed to it.

Correct me if I am wrong, but I don't think that is what is bothering 
you. You are either concerned with one of two cases here. Either you are 
concerned that the attacker may be able to hide the loading of a corrupt 
kernel or that the attacker can corrupt the kernel after loading. In the 
first case, the answer is no; the attacker cannot. The kernel and the 
initrd if it was packed in the kernel are measured and sent to the TPM 
by the ACM running in cache-as-ram before execution begins.

The second case is the flawed scenario, a strawman, if you will. This is 
a runtime-integrity problem that is outside the scope/protections of 
load-time-integrity solutions such as SRTM and DRTM. If the correct 
kernel was loaded and measured, but an attacker already has a position 
in the system that they can corrupt the kernel before the user-space 
init process can be run, then they already won. The attacker is in fact 
already in a more superior position in the system that would not be 
detected or exposed by when config data measurements are sent to the TPM.


> Is there some reason for all this complexity instead of extending the
> PCRs at the early stage when the measurements are taken?


We did have TPM logic in the setup kernel at one point. Within their 
rights, the TPM maintainers took the position that the only TPM 
interface logic should be the existing driver. If we wanted to interface 
with the TPM, we must #include the existing code into the setup kernel. 
The problem is that the mainline TPM driver uses mainline kernel 
features not present in the setup kernel.

v/r,
dps

>>
>> The platform module also registers the securityfs nodes to allow
>> access to TXT register fields on Intel along with the fetching of
>> and writing events to the late launch TPM log.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>> arch/x86/kernel/Makefile   |   1 +
>> arch/x86/kernel/slmodule.c | 508 +++++++++++++++++++++++++++++++++++++
>> 2 files changed, 509 insertions(+)
>> create mode 100644 arch/x86/kernel/slmodule.c
>>
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index a7ca7ca16174..bed87b1c49a2 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -83,6 +83,7 @@ obj-$(CONFIG_IA32_EMULATION)    += tls.o
>> obj-y                += step.o
>> obj-$(CONFIG_INTEL_TXT)        += tboot.o
>> obj-$(CONFIG_SECURE_LAUNCH)    += slaunch.o
>> +obj-$(CONFIG_SECURE_LAUNCH)    += slmodule.o
>> obj-$(CONFIG_ISA_DMA_API)    += i8237.o
>> obj-y                += stacktrace.o
>> obj-y                += cpu/
>> diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
>> new file mode 100644
>> index 000000000000..64010bac038c
>> --- /dev/null
>> +++ b/arch/x86/kernel/slmodule.c
>> @@ -0,0 +1,508 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Secure Launch late validation/setup, securityfs exposure and finalization.
>> + *
>> + * Copyright (c) 2025 Apertus Solutions, LLC
>> + * Copyright (c) 2025 Assured Information Security, Inc.
>> + * Copyright (c) 2025, Oracle and/or its affiliates.
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/fs.h>
>> +#include <linux/init.h>
>> +#include <linux/linkage.h>
>> +#include <linux/mm.h>
>> +#include <linux/io.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/security.h>
>> +#include <linux/memblock.h>
>> +#include <linux/tpm.h>
>> +#include <asm/segment.h>
>> +#include <asm/sections.h>
>> +#include <crypto/sha2.h>
>> +#include <linux/slr_table.h>
>> +#include <linux/slaunch.h>
>> +
>> +/*
>> + * The macro DECLARE_TXT_PUB_READ_U is used to read values from the TXT
>> + * public registers as unsigned values.
>> + */
>> +#define DECLARE_TXT_PUB_READ_U(size, fmt, msg_size)            \
>> +static ssize_t txt_pub_read_u##size(unsigned int offset,        \
>> +        loff_t *read_offset,                    \
>> +        size_t read_len,                    \
>> +        char __user *buf)                    \
>> +{                                    \
>> +    char msg_buffer[msg_size];                    \
>> +    u##size reg_value = 0;                        \
>> +    void __iomem *txt;                        \
>> +                                    \
>> +    txt = ioremap(TXT_PUB_CONFIG_REGS_BASE,                \
>> +            TXT_NR_CONFIG_PAGES * PAGE_SIZE);        \
>> +    if (!txt)                            \
>> +        return -EFAULT;                        \
>> +    memcpy_fromio(&reg_value, txt + offset, sizeof(u##size));    \
>> +    iounmap(txt);                            \
>> +    snprintf(msg_buffer, msg_size, fmt, reg_value);            \
>> +    return simple_read_from_buffer(buf, read_len, read_offset,    \
>> +            &msg_buffer, msg_size);                \
>> +}
>> +
>> +DECLARE_TXT_PUB_READ_U(8, "%#04x\n", 6);
>> +DECLARE_TXT_PUB_READ_U(32, "%#010x\n", 12);
>> +DECLARE_TXT_PUB_READ_U(64, "%#018llx\n", 20);
>> +
>> +#define DECLARE_TXT_FOPS(reg_name, reg_offset, reg_size)        \
>> +static ssize_t txt_##reg_name##_read(struct file *flip,            \
>> +        char __user *buf, size_t read_len, loff_t *read_offset)    \
>> +{                                    \
>> +    return txt_pub_read_u##reg_size(reg_offset, read_offset,    \
>> +            read_len, buf);                    \
>> +}                                    \
>> +static const struct file_operations reg_name##_ops = {            \
>> +    .read = txt_##reg_name##_read,                    \
>> +}
>> +
>> +DECLARE_TXT_FOPS(sts, TXT_CR_STS, 64);
>> +DECLARE_TXT_FOPS(ests, TXT_CR_ESTS, 8);
>> +DECLARE_TXT_FOPS(errorcode, TXT_CR_ERRORCODE, 32);
>> +DECLARE_TXT_FOPS(didvid, TXT_CR_DIDVID, 64);
>> +DECLARE_TXT_FOPS(e2sts, TXT_CR_E2STS, 64);
>> +DECLARE_TXT_FOPS(ver_emif, TXT_CR_VER_EMIF, 32);
>> +DECLARE_TXT_FOPS(scratchpad, TXT_CR_SCRATCHPAD, 64);
>> +
>> +/*
>> + * Securityfs exposure
>> + */
>> +struct memfile {
>> +    char *name;
>> +    void *addr;
>> +    size_t size;
>> +};
>> +
>> +static struct memfile sl_evtlog = {"eventlog", NULL, 0};
>> +static void *txt_heap;
>> +static struct txt_heap_event_log_pointer2_1_element *evtlog21;
>> +static DEFINE_MUTEX(sl_evt_log_mutex);
>> +static struct tcg_efi_specid_event_head *efi_head;
>> +
>> +static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
>> +                  size_t count, loff_t *pos)
>> +{
>> +    ssize_t size;
>> +
>> +    if (!sl_evtlog.addr)
>> +        return 0;
>> +
>> +    mutex_lock(&sl_evt_log_mutex);
>> +    size = simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
>> +                       sl_evtlog.size);
>> +    mutex_unlock(&sl_evt_log_mutex);
>> +
>> +    return size;
>> +}
>> +
>> +static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
>> +                   size_t datalen, loff_t *ppos)
>> +{
>> +    ssize_t result;
>> +    char *data;
>> +
>> +    if (!sl_evtlog.addr)
>> +        return 0;
>> +
>> +    /* No partial writes. */
>> +    result = -EINVAL;
>> +    if (*ppos != 0)
>> +        goto out;
>> +
>> +    data = memdup_user(buf, datalen);
>> +    if (IS_ERR(data)) {
>> +        result = PTR_ERR(data);
>> +        goto out;
>> +    }
>> +
>> +    mutex_lock(&sl_evt_log_mutex);
>> +    if (evtlog21)
>> +        result = tpm2_log_event(evtlog21, sl_evtlog.addr,
>> +                    sl_evtlog.size, datalen, data);
>> +    else
>> +        result = tpm_log_event(sl_evtlog.addr, sl_evtlog.size,
>> +                       datalen, data);
>> +    mutex_unlock(&sl_evt_log_mutex);
>> +
>> +    kfree(data);
>> +out:
>> +    return result;
>> +}
>> +
>> +static const struct file_operations sl_evtlog_ops = {
>> +    .read = sl_evtlog_read,
>> +    .write = sl_evtlog_write,
>> +    .llseek    = default_llseek,
>> +};
>> +
>> +struct sfs_file {
>> +    const char *name;
>> +    const struct file_operations *fops;
>> +};
>> +
>> +#define SL_TXT_ENTRY_COUNT    7
>> +static const struct sfs_file sl_txt_files[] = {
>> +    { "sts", &sts_ops },
>> +    { "ests", &ests_ops },
>> +    { "errorcode", &errorcode_ops },
>> +    { "didvid", &didvid_ops },
>> +    { "ver_emif", &ver_emif_ops },
>> +    { "scratchpad", &scratchpad_ops },
>> +    { "e2sts", &e2sts_ops }
>> +};
>> +
>> +/* sysfs file handles */
>> +static struct dentry *slaunch_dir;
>> +static struct dentry *event_file;
>> +static struct dentry *txt_dir;
>> +static struct dentry *txt_entries[SL_TXT_ENTRY_COUNT];
>> +
>> +static long slaunch_expose_securityfs(void)
>> +{
>> +    long ret = 0;
>> +    int i;
>> +
>> +    slaunch_dir = securityfs_create_dir("slaunch", NULL);
>> +    if (IS_ERR(slaunch_dir))
>> +        return PTR_ERR(slaunch_dir);
>> +
>> +    if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
>> +        txt_dir = securityfs_create_dir("txt", slaunch_dir);
>> +        if (IS_ERR(txt_dir)) {
>> +            ret = PTR_ERR(txt_dir);
>> +            goto remove_slaunch;
>> +        }
>> +
>> +        for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++) {
>> +            txt_entries[i] = securityfs_create_file(
>> +                        sl_txt_files[i].name, 0440,
>> +                        txt_dir, NULL,
>> +                        sl_txt_files[i].fops);
>> +            if (IS_ERR(txt_entries[i])) {
>> +                ret = PTR_ERR(txt_entries[i]);
>> +                goto remove_files;
>> +            }
>> +        }
>> +    }
>> +
>> +    if (sl_evtlog.addr) {
>> +        event_file = securityfs_create_file(sl_evtlog.name, 0440,
>> +                            slaunch_dir, NULL,
>> +                            &sl_evtlog_ops);
>> +        if (IS_ERR(event_file)) {
>> +            ret = PTR_ERR(event_file);
>> +            goto remove_files;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +
>> +remove_files:
>> +    if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
>> +        while (--i >= 0)
>> +            securityfs_remove(txt_entries[i]);
>> +        securityfs_remove(txt_dir);
>> +    }
>> +
>> +remove_slaunch:
>> +    securityfs_remove(slaunch_dir);
>> +
>> +    return ret;
>> +}
>> +
>> +static void slaunch_teardown_securityfs(void)
>> +{
>> +    int i;
>> +
>> +    securityfs_remove(event_file);
>> +    if (sl_evtlog.addr) {
>> +        memunmap(sl_evtlog.addr);
>> +        sl_evtlog.addr = NULL;
>> +    }
>> +    sl_evtlog.size = 0;
>> +
>> +    if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
>> +        for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++)
>> +            securityfs_remove(txt_entries[i]);
>> +
>> +        securityfs_remove(txt_dir);
>> +
>> +        if (txt_heap) {
>> +            memunmap(txt_heap);
>> +            txt_heap = NULL;
>> +        }
>> +    }
>> +
>> +    securityfs_remove(slaunch_dir);
>> +}
>> +
>> +static void slaunch_intel_evtlog(void __iomem *txt)
>> +{
>> +    struct slr_entry_log_info *log_info;
>> +    struct txt_os_mle_data *params;
>> +    struct slr_table *slrt;
>> +    void *os_sinit_data;
>> +    u64 base, size;
>> +
>> +    memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
>> +    memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
>> +
>> +    /* now map TXT heap */
>> +    txt_heap = memremap(base, size, MEMREMAP_WB);
>> +    if (!txt_heap)
>> +        slaunch_txt_reset(txt, "Error failed to memremap TXT heap\n",
>> +                  SL_ERROR_HEAP_MAP);
>> +
>> +    params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
>> +
>> +    /* Get the SLRT and remap it */
>> +    slrt = memremap(params->slrt, sizeof(*slrt), MEMREMAP_WB);
>> +    if (!slrt)
>> +        slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
>> +                  SL_ERROR_SLRT_MAP);
>> +    size = slrt->size;
>> +    memunmap(slrt);
>> +
>> +    slrt = memremap(params->slrt, size, MEMREMAP_WB);
>> +    if (!slrt)
>> +        slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
>> +                  SL_ERROR_SLRT_MAP);
>> +
>> +    log_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
>> +    if (!log_info)
>> +        slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
>> +                  SL_ERROR_SLRT_MISSING_ENTRY);
>> +
>> +    sl_evtlog.size = log_info->size;
>> +    sl_evtlog.addr = memremap(log_info->addr, log_info->size,
>> +                  MEMREMAP_WB);
>> +    if (!sl_evtlog.addr)
>> +        slaunch_txt_reset(txt, "Error failed to memremap TPM event log\n",
>> +                  SL_ERROR_EVENTLOG_MAP);
>> +
>> +    memunmap(slrt);
>> +
>> +    /* Determine if this is TPM 1.2 or 2.0 event log */
>> +    if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
>> +            TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
>> +        return; /* looks like it is not 2.0 */
>> +
>> +    /* For TPM 2.0 logs, the extended heap element must be located */
>> +    os_sinit_data = txt_os_sinit_data_start(txt_heap);
>> +
>> +    evtlog21 = tpm2_find_log2_1_element(os_sinit_data);
>> +
>> +    /*
>> +     * If this fails, things are in really bad shape. Any attempt to write
>> +     * events to the log will fail.
>> +     */
>> +    if (!evtlog21)
>> +        slaunch_txt_reset(txt, "Error failed to find TPM20 event log element\n",
>> +                  SL_ERROR_TPM_INVALID_LOG20);
>> +
>> +    /* Save pointer to the EFI SpecID log header */
>> +    efi_head = (struct tcg_efi_specid_event_head *)(sl_evtlog.addr + sizeof(struct tcg_pcr_event));
>> +}
>> +
>> +static void slaunch_tpm2_extend_event(struct tpm_chip *tpm, void __iomem *txt,
>> +                      struct tcg_pcr_event2_head *event)
>> +{
>> +    u16 *alg_id_field = (u16 *)((u8 *)event + sizeof(*event));
>> +    struct tpm_digest *digests;
>> +    u8 *dptr;
>> +    int ret;
>> +    u32 i;
>> +
>> +    /*
>> +     * Early SL code ensured the TPM algorithm information passed via
>> +     * the log is valid. Small sanity check here.
>> +     */
>> +    if (event->count != efi_head->num_algs)
>> +        slaunch_txt_reset(txt, "Event digest count mismatch with event log\n",
>> +                  SL_ERROR_TPM_EVENT_COUNT);
>> +
>> +    digests = kzalloc(efi_head->num_algs * sizeof(*digests), GFP_KERNEL);
>> +    if (!digests)
>> +        slaunch_txt_reset(txt, "Failed to allocate array of digests\n",
>> +                  SL_ERROR_GENERIC);
>> +
>> +    for (i = 0; i < event->count; i++) {
>> +        dptr = (u8 *)alg_id_field + sizeof(u16);
>> +
>> +        /* Setup each digest for the extend */
>> +        digests[i].alg_id = efi_head->digest_sizes[i].alg_id;
>> +        memcpy(&digests[i].digest[0], dptr,
>> +            efi_head->digest_sizes[i].digest_size);
>> +
>> +        alg_id_field = (u16 *)((u8 *)alg_id_field + sizeof(u16) +
>> +                efi_head->digest_sizes[i].digest_size);
>> +    }
>> +
>> +    ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
>> +    if (ret) {
>> +        pr_err("Error extending TPM20 PCR, result: %d\n", ret);
>> +        slaunch_txt_reset(txt, "Failed to extend TPM20 PCR\n",
>> +                  SL_ERROR_TPM_EXTEND);
>> +    }
>> +
>> +    kfree(digests);
>> +}
>> +
>> +static void slaunch_tpm2_extend(struct tpm_chip *tpm, void __iomem *txt)
>> +{
>> +    struct tcg_pcr_event *event_header;
>> +    struct tcg_pcr_event2_head *event;
>> +    int start = 0, end = 0, size;
>> +
>> +    event_header = (struct tcg_pcr_event *)(sl_evtlog.addr +
>> +                        evtlog21->first_record_offset);
>> +
>> +    /* Skip first TPM 1.2 event to get to first TPM 2.0 event */
>> +    event = (struct tcg_pcr_event2_head *)((u8 *)event_header + sizeof(*event_header) +
>> +                           event_header->event_size);
>> +
>> +    while ((void  *)event < sl_evtlog.addr + evtlog21->next_record_offset) {
>> +        size = __calc_tpm2_event_size(event, event_header, false);
>> +        if (!size)
>> +            slaunch_txt_reset(txt, "TPM20 invalid event in event log\n",
>> +                      SL_ERROR_TPM_INVALID_EVENT);
>> +
>> +        /*
>> +         * Marker events indicate where the Secure Launch early stub
>> +         * started and ended adding post launch events. As they are
>> +         * encountered, switch the event type to NO_ACTION so they
>> +         * ignored in when the event log is processed since they are
>> +         * not really measurements.
>> +         */
>> +        if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
>> +            event->event_type = NO_ACTION;
>> +            end = 1;
>> +            break;
>> +        } else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
>> +            event->event_type = NO_ACTION;
>> +            start = 1;
>> +            goto next;
>> +        }
>> +
>> +        if (start)
>> +            slaunch_tpm2_extend_event(tpm, txt, event);
>> +
>> +next:
>> +        event = (struct tcg_pcr_event2_head *)((u8 *)event + size);
>> +    }
>> +
>> +    if (!start || !end)
>> +        slaunch_txt_reset(txt, "Missing start or end events for extending TPM20 PCRs\n",
>> +                  SL_ERROR_TPM_EXTEND);
>> +}
>> +
>> +static void slaunch_tpm_extend(struct tpm_chip *tpm, void __iomem *txt)
>> +{
>> +    struct tpm_event_log_header *event_header;
>> +    struct tcg_pcr_event *event;
>> +    struct tpm_digest digest;
>> +    int start = 0, end = 0;
>> +    int size, ret;
>> +
>> +    event_header = (struct tpm_event_log_header *)sl_evtlog.addr;
>> +    event = (struct tcg_pcr_event *)((u8 *)event_header +
>> +                sizeof(*event_header));
>> +
>> +    while ((void  *)event < sl_evtlog.addr + event_header->next_event_offset) {
>> +        size = sizeof(*event) + event->event_size;
>> +
>> +        /*
>> +         * See comments in slaunch_tpm2_extend() concerning these special
>> +         * event types.
>> +         */
>> +        if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
>> +            event->event_type = NO_ACTION;
>> +            end = 1;
>> +            break;
>> +        } else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
>> +            event->event_type = NO_ACTION;
>> +            start = 1;
>> +            goto next;
>> +        }
>> +
>> +        if (start) {
>> +            memset(&digest.digest[0], 0, TPM_MAX_DIGEST_SIZE);
>> +            digest.alg_id = TPM_ALG_SHA1;
>> +            memcpy(&digest.digest[0], &event->digest[0],
>> +                   SHA1_DIGEST_SIZE);
>> +
>> +            ret = tpm_pcr_extend(tpm, event->pcr_idx, &digest);
>> +            if (ret) {
>> +                pr_err("Error extending TPM12 PCR, result: %d\n", ret);
>> +                slaunch_txt_reset(txt, "Failed to extend TPM12 PCR\n",
>> +                          SL_ERROR_TPM_EXTEND);
>> +            }
>> +        }
>> +
>> +next:
>> +        event = (struct tcg_pcr_event *)((u8 *)event + size);
>> +    }
>> +
>> +    if (!start || !end)
>> +        slaunch_txt_reset(txt, "Missing start or end events for extending TPM12 PCRs\n",
>> +                  SL_ERROR_TPM_EXTEND);
>> +}
>> +
>> +static void slaunch_pcr_extend(void __iomem *txt)
>> +{
>> +    struct tpm_chip *tpm;
>> +    int rc;
>> +
>> +    tpm = tpm_default_chip();
>> +    if (!tpm)
>> +        slaunch_txt_reset(txt, "Could not get default TPM chip\n",
>> +                  SL_ERROR_TPM_INIT);
>> +
>> +    rc = tpm_chip_set_locality(tpm, 2);
>> +    if (rc)
>> +        slaunch_txt_reset(txt, "Could not set TPM chip locality 2\n",
>> +                  SL_ERROR_TPM_INIT);
>> +
>> +    if (evtlog21)
>> +        slaunch_tpm2_extend(tpm, txt);
>> +    else
>> +        slaunch_tpm_extend(tpm, txt);
>> +}
>> +
>> +static int __init slaunch_module_init(void)
>> +{
>> +    void __iomem *txt;
>> +
>> +    /* Check to see if Secure Launch happened */
>> +    if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
>> +        (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
>> +        return 0;
>> +
>> +    txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
>> +              PAGE_SIZE);
>> +    if (!txt)
>> +        panic("Error ioremap of TXT priv registers\n");
>> +
>> +    /* Only Intel TXT is supported at this point */
>> +    slaunch_intel_evtlog(txt);
>> +    slaunch_pcr_extend(txt);
>> +    iounmap(txt);
>> +
>> +    return slaunch_expose_securityfs();
>> +}
>> +
>> +static void __exit slaunch_module_exit(void)
>> +{
>> +    slaunch_teardown_securityfs();
>> +}
>> +
>> +late_initcall(slaunch_module_init);
>> +__exitcall(slaunch_module_exit);
>> --
>> 2.39.3
>>


