Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D91F4C31
	for <lists+linux-efi@lfdr.de>; Fri,  8 Nov 2019 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKHMzG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 Nov 2019 07:55:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39216 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfKHMzG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 8 Nov 2019 07:55:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8CnL0r161752;
        Fri, 8 Nov 2019 12:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=0ukG+qNUolT6jTLSQd6brM8auZXhJs3nqPYpJUiV9c4=;
 b=K4CxdzvT0OCCSJFEF9z3tUWjap6BZZwswfiN/LWm7Jn5OoIIa2/OpZHA3hujCFKiqd9Q
 fHVYXprYZpEmlvzaAOaB4tiYRKltW0OOevBQRoeeHBL0JsK+gqq7W2bePOHgTdR2L+9E
 samDKZJVElgizBgD+ee7v/PZ4k6YC/wmgw8d2oTKMp9/eALQcZTHqQxUxeQc6jBXbp2L
 yQ5U0vTnbc1Q/zrU2kEdTZFca7tRd17G3rKL/cOe05Tf2m8dbgo7oQzetqyiDuD8/1ye
 SSsR4f1iEa+Nl8zvSisJcHd47AP+t6UlfkqvX4sy3crzplYTQhRn89KRcUUjVMx05bcB nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w41w1d50m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 12:53:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA8CmilX046841;
        Fri, 8 Nov 2019 12:53:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w41wcnwvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 12:53:01 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA8CqtW4025702;
        Fri, 8 Nov 2019 12:52:57 GMT
Received: from tomti.i.net-space.pl (/10.175.202.125)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 04:52:55 -0800
Date:   Fri, 8 Nov 2019 13:52:48 +0100
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
Message-ID: <20191108125248.drmm7xakn7t7oyul@tomti.i.net-space.pl>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
 <20191104151354.28145-3-daniel.kiper@oracle.com>
 <20191108100930.GA4503@zn.tnic>
 <20191108104702.vwfmvehbeuza4j5w@tomti.i.net-space.pl>
 <20191108110703.GB4503@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108110703.GB4503@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=951
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080128
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 08, 2019 at 12:07:03PM +0100, Borislav Petkov wrote:
> On Fri, Nov 08, 2019 at 11:47:02AM +0100, Daniel Kiper wrote:
> > Yeah, you are right. Would you like me to repost whole patch series or
> > could you fix it before committing?
>
> Lemme finish looking at patch 3 first.
>
> If you have to resend, please remove "This patch" and "We" in your text.

OK, got your comments. I will repost the patch series probably on Tuesday.
I hope that it will land in 5.5 then.

Daniel
