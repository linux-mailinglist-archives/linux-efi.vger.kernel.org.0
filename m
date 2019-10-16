Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6402FD8EF2
	for <lists+linux-efi@lfdr.de>; Wed, 16 Oct 2019 13:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbfJPLHr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Oct 2019 07:07:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40710 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfJPLHr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Oct 2019 07:07:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GB47jo131252;
        Wed, 16 Oct 2019 11:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=aWHhLYwSawiorx+Po3WUPkLbtnXvsVxnqtcmobZcGC8=;
 b=bJIkwwcHuHE3suC8BGZ3JOjcpOQL6l0zoXgHJGQZbQquOA5MAxRBEVpxXLMxIR5gl2wf
 BzuMl819pP84XBq4+YgEhOzRBp3RuxrT0vB7xBVd39/SlTOvR5Ely4dTNHU2SPxx6DyM
 bYpN/2EN/rogOnwUJwyiaiDrhLAGUFk2qb5ZVzbk4IUaQQCT3v5cQ+epN8llR1D3hqan
 9ylP+3KNLSiA/jAqV8TifV1xu9BIi9ZeB2MVwURUk0eVLpBVly5+zmT570h20J6NI8og
 360AuzuR4T7YcZEE0536ojYSWbstq6Tu3kAAq0ooOv0k3UP2iALuOZRBKnt5VpAYiYYP uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vk68up352-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 11:07:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9GB2a8w136503;
        Wed, 16 Oct 2019 11:07:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vnxv9dsxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 11:07:03 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9GB6nED022214;
        Wed, 16 Oct 2019 11:06:55 GMT
Received: from tomti.i.net-space.pl (/10.175.219.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Oct 2019 11:06:48 +0000
Date:   Wed, 16 Oct 2019 13:06:42 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
Subject: Re: [PATCH v3 0/3] x86/boot: Introduce the kernel_info et consortes
Message-ID: <20191016110642.5q3bm73vi6o6gn5r@tomti.i.net-space.pl>
References: <20191009105358.32256-1-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009105358.32256-1-daniel.kiper@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=727
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=812 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160100
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 09, 2019 at 12:53:55PM +0200, Daniel Kiper wrote:
> Hi,
>
> Due to very limited space in the setup_header this patch series introduces new
> kernel_info struct which will be used to convey information from the kernel to
> the bootloader. This way the boot protocol can be extended regardless of the
> setup_header limitations. Additionally, the patch series introduces some
> convenience features like the setup_indirect struct and the
> kernel_info.setup_type_max field.
>
> Daniel
>
>  Documentation/x86/boot.rst             | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  arch/x86/boot/Makefile                 |   2 +-
>  arch/x86/boot/compressed/Makefile      |   4 +-
>  arch/x86/boot/compressed/kaslr.c       |  12 ++++++
>  arch/x86/boot/compressed/kernel_info.S |  22 +++++++++++
>  arch/x86/boot/header.S                 |   3 +-
>  arch/x86/boot/tools/build.c            |   5 +++
>  arch/x86/include/uapi/asm/bootparam.h  |  16 +++++++-
>  arch/x86/kernel/e820.c                 |  11 ++++++
>  arch/x86/kernel/kdebugfs.c             |  20 ++++++++--
>  arch/x86/kernel/ksysfs.c               |  30 ++++++++++----
>  arch/x86/kernel/setup.c                |   4 ++
>  arch/x86/mm/ioremap.c                  |  11 ++++++
>  13 files changed, 292 insertions(+), 16 deletions(-)
>
> Daniel Kiper (3):
>       x86/boot: Introduce the kernel_info
>       x86/boot: Introduce the kernel_info.setup_type_max
>       x86/boot: Introduce the setup_indirect

hpa, ping?

Daniel
