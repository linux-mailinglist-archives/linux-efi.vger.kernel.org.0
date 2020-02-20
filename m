Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54782165F3A
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 14:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgBTNxn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 08:53:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39998 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgBTNxn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Feb 2020 08:53:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KDqrbZ105555;
        Thu, 20 Feb 2020 13:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5BWzSGF2uojM+DjzSu0V+dubWkIF7yCH4B55xfk9BnE=;
 b=QvBNlN36xMUcnM4YnJDz/xUCe0QbHQvr/wV3FJORQjJJHuJhIgk9qvQwy2ufyh67p6RG
 dtMze10zshc4jXqs1JQU7AcanwsvgwpEI6dGEnjoC/Rt+PAFhCsVOC7cBNa0XsEc0QUj
 RRwX594xpE4D7Yrar6Hp/g7/VXTLrO9AsqUcYVCI6gXZ9Ldsz7AIycQHfNQRqKDqWnyK
 Yqpa3pT/5PnatvsLIzkOwZbV2zi1lNoo15S+5R8wpFb8B3m7Ywqx31gzxN2wKPhrhViC
 BP4kkfQcE4m65+QpjB8d5PqiHSxbr1t4jnmEEitjpK9Dyx+79sIO2+ELctXpp2EYJgJH jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y8udd9tan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 13:53:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KDq4Pe117093;
        Thu, 20 Feb 2020 13:53:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2y8ud61gb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 13:53:27 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01KDrObo013980;
        Thu, 20 Feb 2020 13:53:24 GMT
Received: from tomti.i.net-space.pl (/10.175.183.233)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 05:53:23 -0800
Date:   Thu, 20 Feb 2020 14:53:19 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, lersek@redhat.com, leif@nuviainc.com,
        pjones@redhat.com, mjg59@google.com, agraf@csgraf.de,
        ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        nivedita@alum.mit.edu, James.Bottomley@hansenpartnership.com
Subject: Re: [RFC PATCH 0/3] efi: put an API version number in the PE/COFF
 header
Message-ID: <20200220135319.7rqromng7jmyc2rw@tomti.i.net-space.pl>
References: <20200220110649.1303-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220110649.1303-1-ardb@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200105
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 20, 2020 at 12:06:46PM +0100, Ard Biesheuvel wrote:
> After having added new ways to load the initrd and the mixed mode kernel,
> we will need to tell the loader about this, so it can use the new, generic
> method if supported, and fall back to the existing method(s) otherwise.
>
> This is an RFC - if there are better ways to record this in the image
> somehow, please shout.
>
> Cc: lersek@redhat.com
> Cc: leif@nuviainc.com
> Cc: pjones@redhat.com
> Cc: mjg59@google.com
> Cc: agraf@csgraf.de
> Cc: ilias.apalodimas@linaro.org
> Cc: xypron.glpk@gmx.de
> Cc: daniel.kiper@oracle.com
> Cc: nivedita@alum.mit.edu
> Cc: James.Bottomley@hansenpartnership.com

For all the patches Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>...

I hope that we will see a bootloader, GRUB preferred, implementation for
this thing soon...

Daniel
