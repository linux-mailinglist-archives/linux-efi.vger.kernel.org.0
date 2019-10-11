Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D053D47C6
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 20:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfJKSl2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 14:41:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33262 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbfJKSl2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 14:41:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BIdaJ8049496;
        Fri, 11 Oct 2019 18:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=q+1C5Mtn23BF1SUx+RWPFEV8zs3fXl/8LqWIqbp/bIE=;
 b=YmT7Pvemj9GSVzgF5YKzbCzsXUu1HgLCCz70z9IZ2m02RqMz1f8TliBIZCc72vV9r8wY
 k37BxKQ2NxjvwM5Rdn3fvbahdL4o45zl3V2txJaXhg/8tC720bmu95RDsUG2khp1ASXj
 ZtBQJUJH/7vLM0Q0/68B1DCDBkwzpupKR3gGbwvaVjLEHWAbHRU31FEZ+ylaaRuf/JBM
 R3kKU4v7F0ESTudEzAXcexQtH3H11szLvmh8FOVJhsI6vAp/cwu/Is+97tVY7yLcR/Mz
 G7djLQ730xW0Ec1uAcEZ3i2CMKsxxzH7WgZqGvcSN4LDCGfCAajfMqiiOMcfL/cVRWaD wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vekts35vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 18:40:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BIc9m3173341;
        Fri, 11 Oct 2019 18:40:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vje2yhmns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 18:40:41 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9BIeeLN002646;
        Fri, 11 Oct 2019 18:40:40 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 18:40:39 +0000
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 0061F6A00F3; Fri, 11 Oct 2019 14:43:57 -0400 (EDT)
Date:   Fri, 11 Oct 2019 14:43:57 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Daniel Kiper <daniel.kiper@oracle.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ard.biesheuvel@linaro.org,
        boris.ostrovsky@oracle.com, bp@alien8.de, corbet@lwn.net,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        eric.snowberg@oracle.com, hpa@zytor.com, jgross@suse.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
Subject: Re: [PATCH v3 1/3] x86/boot: Introduce the kernel_info
Message-ID: <20191011184357.GI691@char.us.oracle.com>
References: <20191009105358.32256-1-daniel.kiper@oracle.com>
 <20191009105358.32256-2-daniel.kiper@oracle.com>
 <181249b6-5833-6f29-7d38-6dacc3f8ee62@infradead.org>
 <20191010094349.la3sjiuiikmegjck@tomti.i.net-space.pl>
 <cb5bcff5-e787-82c4-790d-71695291d552@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5bcff5-e787-82c4-790d-71695291d552@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=985
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110156
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> >>> +be prefixed with header/magic and its size, e.g.:
> >>> +
> >>> +  kernel_info:
> >>> +          .ascii  "LToP"          /* Header, Linux top (structure). */
> >>> +          .long   kernel_info_var_len_data - kernel_info
> >>> +          .long   kernel_info_end - kernel_info
> >>> +          .long   0x01234567      /* Some fixed size data for the bootloaders. */
> >>> +  kernel_info_var_len_data:
> >>> +  example_struct:                 /* Some variable size data for the bootloaders. */
> >>> +          .ascii  "EsTT"          /* Header/Magic. */
> >>> +          .long   example_struct_end - example_struct
> >>> +          .ascii  "Struct"
> >>> +          .long   0x89012345
> >>> +  example_struct_end:
> >>> +  example_strings:                /* Some variable size data for the bootloaders. */
> >>> +          .ascii  "EsTs"          /* Header/Magic. */
> >>
> >> Where do the Magic values "EsTT" and "EsTs" come from?
> >> where are they defined?
> > 
> > EsTT == Example STrucT
> > EsTs == Example STringS
> > 
> > Anyway, it can be anything which does not collide with existing variable
> > length data magics. There are none right now. So, it can be anything.
> > Maybe I should add something saying that.
> 
> Yes, please.

Or make it very clear they are examples, says "1234" or "ABCD" or such.

> 
> thanks.
> -- 
> ~Randy
