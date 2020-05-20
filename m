Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718261DBC99
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgETSUl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 14:20:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51922 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgETSUk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 14:20:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KIHGPR176519;
        Wed, 20 May 2020 18:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ACmokpqXYZSbV+e71YnNK1Adelyq5FdKBJFttORpD9I=;
 b=sdkDcb3mz3/oo8FughW9J4Vd3XiT8dZyLxMTND4b/r6Q0pXe1J+LrynAd+MCm+hjrSCB
 CebvsyPVXgBQEl7f4sexXN2wVBO9DjgSNkjV7yGJStapNGk2IYwHzQ1z3qNjLHMQQEj/
 eQaM2QzvGmPYORXpgQAWrsCNvw+6GHvv1r/SE4aYjfHwkN26hDCoaePY7XZ+RHgTCCFr
 jEYZXKF8NPk+VstL8pzg6Ndd/PZmJOE8edS37HsWY3icO8pV5UwyX5gKvA4o3RgJvpZm
 KphPyRo6Si/R+mkH2O4lDQt8PevtD5z+LxxJ3DNWUdfSYITpnvHtfW0BfLo4SyfX5MAD qw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3127krcqfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 18:20:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KIDAVI187265;
        Wed, 20 May 2020 18:20:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 312t38bxkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 18:20:32 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KIKUnW032164;
        Wed, 20 May 2020 18:20:30 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 11:20:29 -0700
Date:   Wed, 20 May 2020 21:20:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [efi:next 39/40]
 drivers/firmware/efi/libstub/efi-stub-helper.c:265 efi_convert_cmdline()
 warn: qualifier 'l' ignored for %s specifier
Message-ID: <20200520182022.GS3041@kadam>
References: <20200520140903.GA30374@kadam>
 <20200520154308.GA3184088@rani.riverdale.lan>
 <20200520175449.GR3041@kadam>
 <20200520180008.GA3428271@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520180008.GA3428271@rani.riverdale.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200148
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 02:00:08PM -0400, Arvind Sankar wrote:
> On Wed, May 20, 2020 at 08:54:49PM +0300, Dan Carpenter wrote:
> > On Wed, May 20, 2020 at 11:43:08AM -0400, Arvind Sankar wrote:
> > > On Wed, May 20, 2020 at 05:09:03PM +0300, Dan Carpenter wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> > > > head:   e5fbadd1179cdadeaa44d71a9ec068c5bc100524
> > > > commit: 85f5afd4322d294a7eca0d304744a1646113fbd9 [39/40] efi/libstub: Use snprintf with %ls to convert the command line
> > > > config: x86_64-defconfig (attached as .config)
> > > > 
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > 
> > > > New smatch warnings:
> > > > drivers/firmware/efi/libstub/efi-stub-helper.c:265 efi_convert_cmdline() warn: qualifier 'l' ignored for %s specifier
> > > > 
> > > > # https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=85f5afd4322d294a7eca0d304744a1646113fbd9
> > > > git remote add efi https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
> > > > git remote update efi
> > > > git checkout 85f5afd4322d294a7eca0d304744a1646113fbd9
> > > > vim +/l +265 drivers/firmware/efi/libstub/efi-stub-helper.c
> > > > 
> > > > c625d1c203941f drivers/firmware/efi/efi-stub-helper.c         H. Peter Anvin 2013-09-20  258  	options_bytes++;	/* NUL termination */
> > > > 9403e462fb5ffa drivers/firmware/efi/efi-stub-helper.c         Leif Lindholm  2014-04-04  259  
> > > > 1e45bf7372c48c drivers/firmware/efi/libstub/efi-stub-helper.c Ard Biesheuvel 2020-02-10  260  	status = efi_allocate_pages(options_bytes, &cmdline_addr, max_addr);
> > > > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  261  	if (status != EFI_SUCCESS)
> > > > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  262  		return NULL;
> > > > 5fef3870c572a3 drivers/firmware/efi/efi-stub-helper.c         Roy Franz      2013-09-22  263  
> > > > 85f5afd4322d29 drivers/firmware/efi/libstub/efi-stub-helper.c Arvind Sankar  2020-05-18  264  	snprintf((char *)cmdline_addr, options_bytes, "%.*ls",
> > > >                                                                                                                                                   ^
> > > > The "l" doesn't make sense here?
> > > 
> > > The previous patches add support for wide strings to the version of
> > > snprintf used here.
> > 
> > Ah.  Thanks.  I will update the Smatch check.
> > 
> > regards,
> > dan carpenter
> > 
> Note that the main kernel's printf still doesn't support it. It's only
> been added to the version in drivers/firmware/efi/libstub/vsprintf.c
> (added as part of this series).

Ah... I looked and looked at lib/vsprintf.c and wondered if I was going
mad.  :P Thanks.

regards,
dan carpenter
