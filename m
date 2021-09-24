Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136B3416B36
	for <lists+linux-efi@lfdr.de>; Fri, 24 Sep 2021 07:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244129AbhIXFeU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Sep 2021 01:34:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243369AbhIXFeU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Sep 2021 01:34:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18O4TxLE003727;
        Fri, 24 Sep 2021 01:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LcclFexTC3W4CGWQ05F30N7TENmKQs3CWJF8lIJhAyA=;
 b=fM5r0pOd7rJd2mnURChsSfJfJrX/C+3BofObflhTYGzVXv/HEJS9Aw8BgIC//ggGIR4j
 CZ5JxdcP59VcALFL5IzVij2oY4zwlRyWWbJs8bYZFXoi5eLF6aEHqAyx0sRU0twQi+Nx
 uTzT35Ud5rz3mMLTSHcDte6njyO8gAKbwGxAXdnivxmbV3hoFkXGse9K5ImTnY3FP/yx
 Dcg6IMAClTzZSYBturZR2pFZSHk8drui/RqjiPVFtbOoDuEmvxDYqAtOWfweNAxqZrTZ
 HQI3Eeh+Tf3jj5APaqHV6+/E8KJV71sFQyUh51zWXPgx91EVjartcf89ESTdpFpWq0zU zQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b97px199p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 01:32:30 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18O5WBU3010032;
        Fri, 24 Sep 2021 05:32:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3b93gb1yvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 05:32:28 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18O5RWr150528586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 05:27:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A77234C04E;
        Fri, 24 Sep 2021 05:32:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26CB04C050;
        Fri, 24 Sep 2021 05:32:23 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.159.121])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Sep 2021 05:32:23 +0000 (GMT)
Date:   Fri, 24 Sep 2021 08:32:21 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] memblock: cleanup memblock_free interface
Message-ID: <YU1i5YyldfS1HH0j@linux.ibm.com>
References: <20210923074335.12583-1-rppt@kernel.org>
 <20210923074335.12583-4-rppt@kernel.org>
 <1101e3c7-fcb7-a632-8e22-47f4a01ea02e@csgroup.eu>
 <YUxsgN/uolhn1Ok+@linux.ibm.com>
 <96e3da9f-70ff-e5c0-ef2e-cf0b636e5695@csgroup.eu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <96e3da9f-70ff-e5c0-ef2e-cf0b636e5695@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EYYWPQtbK60SNKLXoEtnrAemGAQvCJn5
X-Proofpoint-GUID: EYYWPQtbK60SNKLXoEtnrAemGAQvCJn5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_01,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=856 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109240031
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 23, 2021 at 03:54:46PM +0200, Christophe Leroy wrote:
> 
> Le 23/09/2021 à 14:01, Mike Rapoport a écrit :
> > On Thu, Sep 23, 2021 at 11:47:48AM +0200, Christophe Leroy wrote:
> > > 
> > > 
> > > Le 23/09/2021 à 09:43, Mike Rapoport a écrit :
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > For ages memblock_free() interface dealt with physical addresses even
> > > > despite the existence of memblock_alloc_xx() functions that return a
> > > > virtual pointer.
> > > > 
> > > > Introduce memblock_phys_free() for freeing physical ranges and repurpose
> > > > memblock_free() to free virtual pointers to make the following pairing
> > > > abundantly clear:
> > > > 
> > > > 	int memblock_phys_free(phys_addr_t base, phys_addr_t size);
> > > > 	phys_addr_t memblock_phys_alloc(phys_addr_t base, phys_addr_t size);
> > > > 
> > > > 	void *memblock_alloc(phys_addr_t size, phys_addr_t align);
> > > > 	void memblock_free(void *ptr, size_t size);
> > > > 
> > > > Replace intermediate memblock_free_ptr() with memblock_free() and drop
> > > > unnecessary aliases memblock_free_early() and memblock_free_early_nid().
> > > > 
> > > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > ---
> > > 
> > > > diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> > > > index 1a04e5bdf655..37826d8c4f74 100644
> > > > --- a/arch/s390/kernel/smp.c
> > > > +++ b/arch/s390/kernel/smp.c
> > > > @@ -723,7 +723,7 @@ void __init smp_save_dump_cpus(void)
> > > >    			/* Get the CPU registers */
> > > >    			smp_save_cpu_regs(sa, addr, is_boot_cpu, page);
> > > >    	}
> > > > -	memblock_free(page, PAGE_SIZE);
> > > > +	memblock_phys_free(page, PAGE_SIZE);
> > > >    	diag_amode31_ops.diag308_reset();
> > > >    	pcpu_set_smt(0);
> > > >    }
> > > > @@ -880,7 +880,7 @@ void __init smp_detect_cpus(void)
> > > >    	/* Add CPUs present at boot */
> > > >    	__smp_rescan_cpus(info, true);
> > > > -	memblock_free_early((unsigned long)info, sizeof(*info));
> > > > +	memblock_free(info, sizeof(*info));
> > > >    }
> > > >    /*
> > > 
> > > I'm a bit lost. IIUC memblock_free_early() and memblock_free() where
> > > identical.
> > 
> > Yes, they were, but all calls to memblock_free_early() were using
> > __pa(vaddr) because they had a virtual address at hand.
> 
> I'm still not following. In the above memblock_free_early() was taking
> (unsigned long)info . Was it a bug ? 

Not really because s390 has pa == va:

https://elixir.bootlin.com/linux/latest/source/arch/s390/include/asm/page.h#L169


-- 
Sincerely yours,
Mike.
