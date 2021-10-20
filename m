Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548FA434AA7
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJTMDK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 08:03:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhJTMDK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 08:03:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KBMh4i001140;
        Wed, 20 Oct 2021 08:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=2atfIvf5ixrkwBkxddiwe1JyhuUXA4C0o6cch/eYBP0=;
 b=i+wo5AXB739rhOsrv7fJJkPOW4K+qGHZx2ii3jp9u6G88MfrP6oVw8n17VdHs09AXVQ5
 nIHH4uk73tFrFRk/eLVXVv7CMHekEAz/zWLPBzcGQGN/jpjkVS1NLxIz2i/HMjyZWtZr
 tcxWgJJDuBZ2XixYlug0I2JxKZv5pyn8cfa/bWhZZOBkEGZK0FNMcd9W65nxFbNg9Ibh
 7RTD3e32kfLIORsI/qust+Fh5RDjTbA2GdZ6k+kwIQDihpBf3R1AmrSeElbPMYdQrWJu
 HYtXBiY0nAwcjrS/907/mD9wwX9+QofumBxZ3UJ05fpx7TWNTMyk1xY55mrhGXBdIQiG jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btj6f8qpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 08:00:42 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19KBOCY8007783;
        Wed, 20 Oct 2021 08:00:41 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3btj6f8qmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 08:00:41 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19KBxHGw027484;
        Wed, 20 Oct 2021 12:00:36 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3bqpcc5e9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 12:00:36 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19KC0Y0W36635064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 12:00:34 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E729678091;
        Wed, 20 Oct 2021 12:00:33 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E09CB7807B;
        Wed, 20 Oct 2021 12:00:29 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.92.132])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Oct 2021 12:00:29 +0000 (GMT)
Message-ID: <fb309e2686ca42df2c053cc1b060b1bc774fd3e7.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/3] efi/libstub: Copy confidential computing secret
 area
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Greg KH <gregkh@linuxfoundation.org>,
        Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Oct 2021 08:00:28 -0400
In-Reply-To: <YW+5phDcxynJD2qy@kroah.com>
References: <20211020061408.3447533-1-dovmurik@linux.ibm.com>
         <20211020061408.3447533-2-dovmurik@linux.ibm.com>
         <YW+5phDcxynJD2qy@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fXfdxmVhmW-oHxGkZz5qlolZAwivX7I6
X-Proofpoint-GUID: EdATHeW8N-0HlDMOIkTMqEVygdiToCfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=969 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200070
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2021-10-20 at 08:39 +0200, Greg KH wrote:
> On Wed, Oct 20, 2021 at 06:14:06AM +0000, Dov Murik wrote:
[...]
> > +	help
> > +	  Copy memory reserved by EFI for Confidential Computing (coco)
> > +	  injected secrets, if EFI exposes such a table entry.
> 
> Why would you want to "copy" secret memory?
> 
> This sounds really odd here, it sounds like you are opening up a
> security hole.  Are you sure this is the correct text that everyone
> on the "COCO" group agrees with?

The way this works is that EFI covers the secret area with a boot time
handoff block, which means it gets destroyed as soon as
ExitBootServices is called as a security measure ... if you do nothing
the secret is shredded.  This means you need to make a copy of it
before that happens if there are secrets that need to live beyond the
EFI boot stub.

James


