Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88241F4D60
	for <lists+linux-efi@lfdr.de>; Fri,  8 Nov 2019 14:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfKHNlb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Nov 2019 08:41:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56566 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfKHNlb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Nov 2019 08:41:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8DdJBp173349;
        Fri, 8 Nov 2019 13:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=EN/SCcok43dz7bv91DbkS1Cf4aZc0oMNFHRA92kmMBk=;
 b=ec4plKZTwIJ70M53HTN2vrxpUQlTbWawXoH78zVVd7xv5KQHBovO01FBfvfhKCO2AuBL
 lvaVz/WsLyiMxLpK5y7s975OQslHJ9J038te/d0cV4XdALBup9k5ijXMCuajcMfoa7zW
 5G2pGqtQ9OTKVkZ2ykc1n82NP1VSxjeEKu30lnjkgqE0bCjo/B3AQdahiaIuCMo4cxGP
 hNTC+IfUni0MlRqR1nfMuwWQ45BLaEI+D8LgiFlKr1oUvE9KaFd0v+TBZFjolQ4VQisP
 UHZb7jGUk3MiRKTReK1k6UrngUQ6wHvCpkV6KydGbO6dpxETtlR3pyK+OLKaoyvon4A7 +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w41w15b8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 13:39:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8DdBFa108201;
        Fri, 8 Nov 2019 13:39:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w41whtvpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 13:39:45 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA8DddH7017631;
        Fri, 8 Nov 2019 13:39:39 GMT
Received: from tomti.i.net-space.pl (/10.175.202.125)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 05:39:38 -0800
Date:   Fri, 8 Nov 2019 14:39:31 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, eric.snowberg@oracle.com, hpa@zytor.com,
        jgross@suse.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 2/3] x86/boot: Introduce the kernel_info.setup_type_max
Message-ID: <20191108133931.ah2an7o4wqqax6fj@tomti.i.net-space.pl>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
 <20191104151354.28145-3-daniel.kiper@oracle.com>
 <20191108100930.GA4503@zn.tnic>
 <20191108104702.vwfmvehbeuza4j5w@tomti.i.net-space.pl>
 <20191108110703.GB4503@zn.tnic>
 <20191108125248.drmm7xakn7t7oyul@tomti.i.net-space.pl>
 <20191108130338.GD4503@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108130338.GD4503@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=891
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=969 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080136
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 08, 2019 at 02:03:38PM +0100, Borislav Petkov wrote:
> On Fri, Nov 08, 2019 at 01:52:48PM +0100, Daniel Kiper wrote:
> > OK, got your comments. I will repost the patch series probably on Tuesday.
> > I hope that it will land in 5.5 then.
>
> I don't see why not if you base it ontop of tip:x86/boot and test it
> properly before sending.

Great!

> Out of curiosity, is there any particular reason this should be in 5.5?

Just want to have it done... :-))) ...and continue work on stuff which
depends on it.

Daniel
