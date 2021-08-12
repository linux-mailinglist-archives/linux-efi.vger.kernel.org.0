Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368E53EA670
	for <lists+linux-efi@lfdr.de>; Thu, 12 Aug 2021 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbhHLOV6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Aug 2021 10:21:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236287AbhHLOV5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Aug 2021 10:21:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CE4fYR035638;
        Thu, 12 Aug 2021 10:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4rFKLwpJOQMMqGRC+zW+jrbs8nb5tBinDGArMD5AuCw=;
 b=DDXo3ijmM5GI1auEmnXHEpeqylNP3bObxI7sALFa3XRH2C+ofdrsIcEI2plk0LSc8crG
 RCN0wNGobu+OFiMBCnkmKfOMpwjYNXALaPuD2zgMt71o5UtG4i1lD89Mrly7kUdZDM2Y
 sF2xhej/iyVpAmxn7AKQMOff5orbqP+ZJcTATeF0xILVyFhoeMSHt0mLm9IuO6n41wly
 FU0GtQr60AJ94fNDU5c+UJrQKFlbNp5HoEmJGf/BD7NGSQZmcZqQ/ZA6dVJ3MRQO8pkz
 SI0w/TrAC7BdCZON7Mn16bzunmWcZ0MS1wfy4JE/59avd8rs+O2HnR80XlkiyaMjFy8L 4Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ad0qy1vjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 10:21:17 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CEIsOw014713;
        Thu, 12 Aug 2021 14:21:15 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3acf0ktjyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 14:21:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CEHxxE30540192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 14:17:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAC4D52057;
        Thu, 12 Aug 2021 14:21:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.92.71])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5803052069;
        Thu, 12 Aug 2021 14:21:12 +0000 (GMT)
Subject: Re: [PATCH 1/4] block: store a gendisk in struct parsed_partitions
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
References: <20210810154512.1809898-1-hch@lst.de>
 <20210810154512.1809898-2-hch@lst.de>
From:   Stefan Haberland <sth@linux.ibm.com>
Message-ID: <15ddb7b3-8b43-2e36-652c-c6ccb06c7f88@linux.ibm.com>
Date:   Thu, 12 Aug 2021 16:21:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810154512.1809898-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GZUZdAv0WiWL02u5O1Ht1A2vEmREStlc
X-Proofpoint-ORIG-GUID: GZUZdAv0WiWL02u5O1Ht1A2vEmREStlc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_04:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 clxscore=1011 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108120087
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am 10.08.21 um 17:45 schrieb Christoph Hellwig:
> Partition scanning only happens on the whole device, so pass a
> struct gendisk instead of the whole device block_device to the scanners.
> This allows to simplify printing the device name in various places as the
> disk name is available in disk->name.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/partitions/acorn.c   |  4 ++--
>  block/partitions/aix.c     | 20 ++------------------
>  block/partitions/amiga.c   |  7 +++----
>  block/partitions/atari.c   |  4 ++--
>  block/partitions/check.h   |  2 +-
>  block/partitions/cmdline.c |  6 ++----
>  block/partitions/core.c    |  6 +++---
>  block/partitions/efi.c     | 36 +++++++++++++++++-------------------
>  block/partitions/ibm.c     |  4 ++--

for the DASD part:

Looks good.

Reviewed-by: Stefan Haberland <sth@linux.ibm.com>


