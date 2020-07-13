Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871A921E21A
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jul 2020 23:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGMVaw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jul 2020 17:30:52 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:53626 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgGMVau (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jul 2020 17:30:50 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DLEF54003633;
        Mon, 13 Jul 2020 21:29:57 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 328x6fgfmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 21:29:57 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id F14786A;
        Mon, 13 Jul 2020 21:29:54 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 91A5920072156; Mon, 13 Jul 2020 16:29:54 -0500 (CDT)
Message-ID: <20200713212954.444086564@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 13 Jul 2020 16:29:54 -0500
From:   steve.wahl@hpe.com
To:     Steve Wahl <steve.wahl@hpe.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Russ Anderson <rja@hpe.com>
Subject: [patch v3 00/13] Remove UV1 platform support and associated efi=oldmap option
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_17:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130153
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


This series of patches removes support for the UV1 platform and the
efi=old_map kernel command line option.

The documentation for efi=old_map in
Documentation/admin-guide/kernel-parameters.txt was recently touched
and differs between linux-next and the mainline tree.  I will send a
separate patch to fix the documentation when this gets accepted.

The UV1 platform has been out of support for a number of years, has
not had a BIOS update for at least 5 years, and we have not had access
to hardware to test changes on for a while now, either.  

Removing the UV1 platform will improve the clarity of the changes we
would like to make for our forthcoming UV5 Sapphire Rapids platform,
making them easier to review.  And removing the UV1 platform allows
this patch set to also remove the efi=old_map boot option, which seems
to be a natural progression from commit 1f299fad1e312947c974
("efi/x86: Limit EFI old memory map to SGI UV machines")

Changes for v2:
- Diffstats regenerated so they should be accurate now.
- Removed unused variable timeout_base_ns in tlb_uv.c found by lkp@intel.com
- added x86 subsystem to subject line.
Changes for v3:
- Incorporate tags / acks given on earlier versions of this series.

