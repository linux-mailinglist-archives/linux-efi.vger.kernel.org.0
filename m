Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8213FEFFF
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 17:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbhIBPVR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 11:21:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345698AbhIBPVO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 11:21:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182F3fF0001892;
        Thu, 2 Sep 2021 11:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=QbW4x9/Vy805LKx9h6xm30flkNXvZK4xKrhfq2rNVsM=;
 b=qDFtUTnOBAow20c+ML9I06QGddD08jvRtZAvSC152HkG2vxhVePGxTTQMz3r/8yZWsn7
 zVRfuHjo/IoToRA8mEtaoFa/zJave4+fktwcgLoaDxyq3dfD6gUYue6MmrhxntDXIscG
 zTKBoNo+7DV5tEptiNR0j2yLaTD6FF0nzgWCnVICLQYSc70NQhCTgPnoCdt7wWqsBuXh
 5uSCiGwS7+6FSn3orWNg2HF9g4GEuPrI52zAnjgwOLoT39vASqoQotsYrq6cz1WxYLUF
 hY2RNfH9DIJ2DHz8WyFypNMISArR6a/YB/itw+f1KMsRDPvJO0zEC6HjvCROz4yah5Ww 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3au0dy26kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 11:19:57 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 182F3gAC002344;
        Thu, 2 Sep 2021 11:19:57 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3au0dy26jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 11:19:57 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 182FIj8W002983;
        Thu, 2 Sep 2021 15:19:55 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02wdc.us.ibm.com with ESMTP id 3atdxc6ck8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 15:19:55 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 182FJsfd34603420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 15:19:54 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F9D778068;
        Thu,  2 Sep 2021 15:19:54 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E6D978078;
        Thu,  2 Sep 2021 15:19:52 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.89.117])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Sep 2021 15:19:52 +0000 (GMT)
Message-ID: <6cb65cb3bd69ae69bde044f809525e478bdb8512.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] Allow access to confidential computing secret area
 in SEV guests
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Sep 2021 08:19:51 -0700
In-Reply-To: <YTDoS5XycY3gO4MM@kroah.com>
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
         <YTDKUe8rXrr0Zika@kroah.com>
         <e6fb1d54605690cc1877d7140fc9346c22268111.camel@linux.ibm.com>
         <YTDoS5XycY3gO4MM@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X0BBfsUnrgBwFQKASWltwHcWwpPaUlmq
X-Proofpoint-ORIG-GUID: av-NRex120oZ3yXsK5AxQ6f2yUdsz4KH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020091
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2021-09-02 at 17:05 +0200, Greg KH wrote:
> On Thu, Sep 02, 2021 at 07:35:10AM -0700, James Bottomley wrote:
> > On Thu, 2021-09-02 at 14:57 +0200, Greg KH wrote:
> > [...]
> > > Wait, why are you using securityfs for this?
> > > 
> > > securityfs is for LSMs to use. 
> > 
> > No it isn't ... at least not exclusively; we use it for non LSM
> > security purposes as well, like for the TPM BIOS log and for
> > IMA.  What makes you think we should start restricting securityfs
> > to LSMs only?  That's not been the policy up to now.
> 
> Well that was the original intent of the filesystem when it was
> created, but I guess it's really up to the LSM maintainers now what
> they want it for.
> 
> > >  If you want your own filesystem to play around with stuff like
> > > this, great, write your own, it's only 200 lines or less these
> > > days.  We used to do it all the time until people realized they
> > > should just use sysfs for driver stuff.
> > 
> > This is a security purpose (injected key retrieval), so securityfs
> > seems to be the best choice.  It's certainly possible to create a
> > new filesystem, but I really think things with a security purpose
> > should use securityfs so people know where to look for them.
> 
> knowing where to look should not be an issue, as that should be
> documented in Documentation/ABI/ anyway, right?
> 
> It's just the overlap / overreach of using an existing filesystem for
> things that don't seem to be LSM-related that feels odd to me.
> 
> Why not just make a cocofs if those people want a filesystem
> interface?
> It's 200 lines or so these days, if not less, and that way you only
> mount what you actually need for the system.

Secrets transfer is actually broader than confidential computing,
although confidential computing is a first proposed use, so I think
cocofs would be too narrow.

> Why force this into securityfs if it doesn't have to be?

It's not being forced.  Secrets transfer is a security function in the
same way the bios log is.

James


