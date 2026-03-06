Return-Path: <linux-efi+bounces-6265-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM+BFlREq2nJbgEAu9opvQ
	(envelope-from <linux-efi+bounces-6265-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 22:17:08 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561D227D6D
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 22:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E2CE302E13C
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148F231842;
	Fri,  6 Mar 2026 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nA6CgNUj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD231F4615;
	Fri,  6 Mar 2026 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831825; cv=none; b=AY1pgUuxnVYRHccYo3BohpukNZ4MojvQxiHVP/T4zzaJYi1ERxhzkrVX/ASf9Sl6Uue+gYXOmBAZVixDkVr6VIRr5lFatp8D7lU2x28b5gw0rMBHseZ9njBd9xtVqdyxentvMYNS4ZfUxUQyVBOEDgIS+563HA/DaFPDXIIWD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831825; c=relaxed/simple;
	bh=uZuCakPLyV0YhkoEiRG1KRnO5yknVI+iOX2e2p0KbCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgMf+eokxlC8lEW42Egj3K1GHgjJvzr6FuUMN7RhfmZYLgg87ut+coDV7arals2Krb0wM7Qm2ffZ/bSyudlC++8jbaVYCeZ7Rg0sJrOmiC3bAjAtwMFzg1DIUJo/HAiY4cUsMJjSDyI2m2jaS8tVbbOOVMXxqkYHQC42ZsxMEIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nA6CgNUj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772831823; x=1804367823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZuCakPLyV0YhkoEiRG1KRnO5yknVI+iOX2e2p0KbCI=;
  b=nA6CgNUjXPKOsOdpaQjz0H3kCxHeHYmlL/kzsxSn6HZHO6Iz7jaZdR7Y
   WThBAKu2VxKjLEmyinmcbzFDJdhmtv8Otx6oCzxLRtKgzy4g/HKTaJoeV
   OcbhOI3gU6HjKhm/liH8rSbBU0nZw0Ic6W/H3bJ+bTpohOMDAv+7b0u62
   SEERAFpvYMzJECnNfDTnggi/E35CSJogU1McW3v6MVyIYLvzG5hLIdmS9
   VbQMKzAIRv5ikM6hDS0WZDuFrBcwDqVP1DNA0FohV4tCZA+b1qQadZtKV
   igd6RWCA/iVkfln1zDWGBA63XCR80ypEpDgXcLAB6XT9XBJitw0mzhgI0
   g==;
X-CSE-ConnectionGUID: SaFrKbosT6eHdz21T6S6Tg==
X-CSE-MsgGUID: XcGpk8IpTNGdX/bG+7ov1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73864516"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73864516"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 13:17:03 -0800
X-CSE-ConnectionGUID: sLCBQ4W5SDmWOS6uvkx/UQ==
X-CSE-MsgGUID: udzCn7C5Rlef9WYbwV9VVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="219065605"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Mar 2026 13:16:55 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vycXT-000000001Nx-1b5J;
	Fri, 06 Mar 2026 21:16:51 +0000
Date: Sat, 7 Mar 2026 05:16:00 +0800
From: kernel test robot <lkp@intel.com>
To: Vasily Gorbik <gor@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Coiby Xu <coxu@redhat.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 1/1] s390/ipl: Fix missing arch_get_secureboot()
 prototype warning
Message-ID: <202603070500.3pafeTNF-lkp@intel.com>
References: <p01-01.g9ec0a81d34d1.ttbfdx5@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p01-01.g9ec0a81d34d1.ttbfdx5@ub.hpns>
X-Rspamd-Queue-Id: 0561D227D6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.ibm.com,kernel.org,intel.com,redhat.com,huawei.com,ellerman.id.au,gmail.com,alien8.de,zytor.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-6265-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Vasily,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0-rc2]
[also build test ERROR on linus/master]
[cannot apply to next-20260306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasily-Gorbik/s390-ipl-Fix-missing-arch_get_secureboot-prototype-warning/20260305-230453
base:   v7.0-rc2
patch link:    https://lore.kernel.org/r/p01-01.g9ec0a81d34d1.ttbfdx5%40ub.hpns
patch subject: [PATCH 1/1] s390/ipl: Fix missing arch_get_secureboot() prototype warning
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260307/202603070500.3pafeTNF-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070500.3pafeTNF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070500.3pafeTNF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/s390/kernel/ipl.c:24:10: fatal error: 'linux/secure_boot.h' file not found
      24 | #include <linux/secure_boot.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +24 arch/s390/kernel/ipl.c

  > 24	#include <linux/secure_boot.h>
    25	#include <asm/asm-extable.h>
    26	#include <asm/machine.h>
    27	#include <asm/diag.h>
    28	#include <asm/ipl.h>
    29	#include <asm/smp.h>
    30	#include <asm/setup.h>
    31	#include <asm/cpcmd.h>
    32	#include <asm/ebcdic.h>
    33	#include <asm/sclp.h>
    34	#include <asm/checksum.h>
    35	#include <asm/debug.h>
    36	#include <asm/abs_lowcore.h>
    37	#include <asm/os_info.h>
    38	#include <asm/sections.h>
    39	#include <asm/boot_data.h>
    40	#include "entry.h"
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

