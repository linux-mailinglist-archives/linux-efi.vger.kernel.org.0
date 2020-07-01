Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0843B210D5F
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jul 2020 16:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgGAOSd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jul 2020 10:18:33 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:64532 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728712AbgGAOSa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jul 2020 10:18:30 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061E372s032363;
        Wed, 1 Jul 2020 14:17:34 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 32074j9929-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:17:34 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id A1D54A2;
        Wed,  1 Jul 2020 14:17:33 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 6D18F2015D859; Wed,  1 Jul 2020 09:17:32 -0500 (CDT)
Message-ID: <20200701141732.331181649@hpe.com>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 09:17:38 -0500
From:   steve.wahl@hpe.com
To:     Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ardb@kernel.org>,
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
        Steve Wahl <steve.wahl@hpe.com>,
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
Subject: [patch 07/13] Remove support for UV1 platform from uv.h
References: <20200701141731.377252388@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=778 impostorscore=0
 cotscore=-2147483648 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007010102
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

arch/x86/include/asm/uv/uv.h: remove UV1 support

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index ae587ce544f4..45e2e905909b 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -4,7 +4,7 @@
 
 #include <asm/tlbflush.h>
 
-enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC, UV_NON_UNIQUE_APIC};
+enum uv_system_type {UV_NONE, UV_LEGACY_APIC, UV_X2APIC};
 
 struct cpumask;
 struct mm_struct;
-- 
2.12.3


