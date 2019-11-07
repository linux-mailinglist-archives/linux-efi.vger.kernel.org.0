Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15DF2D7F
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 12:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbfKGLd6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Nov 2019 06:33:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53722 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGLd5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Nov 2019 06:33:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7BOd77056436;
        Thu, 7 Nov 2019 11:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Czv8pVqfVxDd0LKsdSWLqwv2PVZZcgc54wLOCYMQZpI=;
 b=IxmL8NC5gDs35jgU5KDXQWFaY6gRj6hkmvOc7nat9QD+kZvucJ3ra2JTVeHCHQJvyMTu
 Ri92gGhFoDOdV+086QQZpBQR+85j3rFpn75uiBe+JJIt6eVElHh5g/GGdaAbeDTGSCB2
 W/1C1jUXTTWhICSoHbN3IOswf8WRZ51u4Jilg8yCj8VDVzzpoAoqmGf5o2Ow6+85Bz0s
 i+sUs3DyIF3avPnqOccY/C2KJ+c1RSp8WRROhlfDPFbH4mcCUkYMVlYAW/YkryitMg6j
 o8zOc1fRM/wOYARIMsUDZcUdDhhNQR51q45jlMviezMw46e+DX30lFJ+Emx5SUQql0T/ Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w41w0wev6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 11:31:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7BSjdh171874;
        Thu, 7 Nov 2019 11:31:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w41wepmft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 11:31:50 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA7BVfka020250;
        Thu, 7 Nov 2019 11:31:46 GMT
Received: from tomti.i.net-space.pl (/10.175.179.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 03:31:40 -0800
Date:   Thu, 7 Nov 2019 12:31:34 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     hpa@zytor.com
Cc:     Borislav Petkov <bp@alien8.de>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ard.biesheuvel@linaro.org,
        boris.ostrovsky@oracle.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        eric.snowberg@oracle.com, jgross@suse.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 0/3] x86/boot: Introduce the kernel_info et consortes
Message-ID: <20191107113134.yl7e4rwxowr52tzf@tomti.i.net-space.pl>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
 <20191106170333.GD28380@zn.tnic>
 <3EABBAB2-5BEF-4FEE-8BB4-9EB4B0180B10@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EABBAB2-5BEF-4FEE-8BB4-9EB4B0180B10@zytor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=632
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=717 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070117
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 06, 2019 at 09:56:48AM -0800, hpa@zytor.com wrote:
> On November 6, 2019 9:03:33 AM PST, Borislav Petkov <bp@alien8.de> wrote:
> >On Mon, Nov 04, 2019 at 04:13:51PM +0100, Daniel Kiper wrote:
> >> Hi,
> >>
> >> Due to very limited space in the setup_header this patch series introduces new
> >> kernel_info struct which will be used to convey information from the kernel to
> >> the bootloader. This way the boot protocol can be extended regardless of the
> >> setup_header limitations. Additionally, the patch series introduces some
> >> convenience features like the setup_indirect struct and the
> >> kernel_info.setup_type_max field.
> >
> >That's all fine and dandy but I'm missing an example about what that'll
> >be used for, in practice.
> >
> >Thx.
>
> For one thing, we already have people asking for more than 4 GiB worth
> of initramfs, and especially with initramfs that huge it would make a
> *lot* of sense to allow loading it in chunks without having to
> concatenate them. I have been asking for a long time for initramfs
> creators to split the kernel-dependent and kernel independent parts
> into separate initramfs modules.

Another user of this patchset is the TrenchBoot project on which we are
working on. We have to introduce separate entry point for Intel TXT MLE
startup code. That is why we need the kernel_info struct.

Daniel
