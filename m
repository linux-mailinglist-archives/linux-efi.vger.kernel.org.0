Return-Path: <linux-efi+bounces-4481-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785EBB1235F
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jul 2025 19:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6A03BD4F7
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jul 2025 17:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38C2BD01B;
	Fri, 25 Jul 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="scTke37e"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0811134BD;
	Fri, 25 Jul 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466289; cv=none; b=W6AwlN7dtygGPa5gFHLgl18JavA8xtbjgegSvlmuhMX0T/viWLUoSDYM1kr/3dSUk83q0oFo94Oh9qMEtKhsxzrdfoc0ZrVddHJy49o3AaJj6e010mkpiylfm8QPsAKEKS+MoHtexsQMmt3Gt2IsRkcOKUCVVg5kugUV7Ml/gpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466289; c=relaxed/simple;
	bh=eVtb6MJ3Sj3SJ1kLyP1ByuhVZUTp9cXrMV59WYm2iog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Caiz9ROd4KJSxrEh+J7sSHa5wGaAz/9pzYD04SMQECffWTxDt07Mq+jF55Tun6302d6yGgI1YocFut2VCg0FR6e5If35OvZsZh88CFQ8bXcVo+Zd6Ruhp/QWtHU+xjv3gyuIxhScIEgfDz6P0Kd9uEkcorN3vXwUfXVNJWHDwYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=scTke37e; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56PHvREK2630400
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 25 Jul 2025 10:57:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56PHvREK2630400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1753466249;
	bh=DST4Ds/rbgndE3+yykqR2X7LIyUlLcUfe9t/MvWH1QI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=scTke37eODu/bP5GVIlzmTFelT2cB6LOzoQnbw6bOLo1xv4LNvk2BmTOvZTgzTEep
	 hd2M+8/nmsu4aES7a7tMxtaAEQSBD3WZ6vY1VzDgNkLx7nzKd65mMKCb/eg0egAKGc
	 zEbuJy7PgmG2D2ddRDh2dmOJ2zlXJnJTO0Qj72X7hytMjxUYMaFBLR0Oa/wbaYIviD
	 +PBStieCyMKlhzdV0ioF2QN826es8ak2k8AOPzR2X0JrK0sTUis2pyWqcnM+cxI5iB
	 9qZqMlzUvareeRMwynm2ucsj2M6BC6QdWA1/c0xyuaUndaiqyn3ETpqrruoU2VDPx1
	 Za1EGyA6k7lWQ==
Message-ID: <1584052d-4d8c-4b4e-b65b-318296d47636@zytor.com>
Date: Fri, 25 Jul 2025 10:57:26 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
To: Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        jpoimboe@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, samitolvanen@google.com, ojeda@kernel.org
References: <20250714102011.758008629@infradead.org>
 <20250714103441.496787279@infradead.org> <aIKZnSuTXn9thrf7@google.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 xsDNBGUPz1cBDACS/9yOJGojBFPxFt0OfTWuMl0uSgpwk37uRrFPTTLw4BaxhlFL0bjs6q+0
 2OfG34R+a0ZCuj5c9vggUMoOLdDyA7yPVAJU0OX6lqpg6z/kyQg3t4jvajG6aCgwSDx5Kzg5
 Rj3AXl8k2wb0jdqRB4RvaOPFiHNGgXCs5Pkux/qr0laeFIpzMKMootGa4kfURgPhRzUaM1vy
 bsMsL8vpJtGUmitrSqe5dVNBH00whLtPFM7IbzKURPUOkRRiusFAsw0a1ztCgoFczq6VfAVu
 raTye0L/VXwZd+aGi401V2tLsAHxxckRi9p3mc0jExPc60joK+aZPy6amwSCy5kAJ/AboYtY
 VmKIGKx1yx8POy6m+1lZ8C0q9b8eJ8kWPAR78PgT37FQWKYS1uAroG2wLdK7FiIEpPhCD+zH
 wlslo2ETbdKjrLIPNehQCOWrT32k8vFNEMLP5G/mmjfNj5sEf3IOKgMTMVl9AFjsINLHcxEQ
 6T8nGbX/n3msP6A36FDfdSEAEQEAAc0WWGluIExpIDx4aW5Aenl0b3IuY29tPsLBDQQTAQgA
 NxYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89XBQkFo5qAAhsDBAsJCAcFFQgJCgsFFgID
 AQAACgkQa70OVx2uN1HUpgv/cM2fsFCQodLArMTX5nt9yqAWgA5t1srri6EgS8W3F+3Kitge
 tYTBKu6j5BXuXaX3vyfCm+zajDJN77JHuYnpcKKr13VcZi1Swv6Jx1u0II8DOmoDYLb1Q2ZW
 v83W55fOWJ2g72x/UjVJBQ0sVjAngazU3ckc0TeNQlkcpSVGa/qBIHLfZraWtdrNAQT4A1fa
 sWGuJrChBFhtKbYXbUCu9AoYmmbQnsx2EWoJy3h7OjtfFapJbPZql+no5AJ3Mk9eE5oWyLH+
 QWqtOeJM7kKvn/dBudokFSNhDUw06e7EoVPSJyUIMbYtUO7g2+Atu44G/EPP0yV0J4lRO6EA
 wYRXff7+I1jIWEHpj5EFVYO6SmBg7zF2illHEW31JAPtdDLDHYcZDfS41caEKOQIPsdzQkaQ
 oW2hchcjcMPAfyhhRzUpVHLPxLCetP8vrVhTvnaZUo0xaVYb3+wjP+D5j/3+hwblu2agPsaE
 vgVbZ8Fx3TUxUPCAdr/p73DGg57oHjgezsDNBGUPz1gBDAD4Mg7hMFRQqlzotcNSxatlAQNL
 MadLfUTFz8wUUa21LPLrHBkUwm8RujehJrzcVbPYwPXIO0uyL/F///CogMNx7Iwo6by43KOy
 g89wVFhyy237EY76j1lVfLzcMYmjBoTH95fJC/lVb5Whxil6KjSN/R/y3jfG1dPXfwAuZ/4N
 cMoOslWkfZKJeEut5aZTRepKKF54T5r49H9F7OFLyxrC/uI9UDttWqMxcWyCkHh0v1Di8176
 jjYRNTrGEfYfGxSp+3jYL3PoNceIMkqM9haXjjGl0W1B4BidK1LVYBNov0rTEzyr0a1riUrp
 Qk+6z/LHxCM9lFFXnqH7KWeToTOPQebD2B/Ah5CZlft41i8L6LOF/LCuDBuYlu/fI2nuCc8d
 m4wwtkou1Y/kIwbEsE/6RQwRXUZhzO6llfoN96Fczr/RwvPIK5SVMixqWq4QGFAyK0m/1ap4
 bhIRrdCLVQcgU4glo17vqfEaRcTW5SgX+pGs4KIPPBE5J/ABD6pBnUUAEQEAAcLA/AQYAQgA
 JhYhBIUq/WFSDTiOvUIqv2u9DlcdrjdRBQJlD89ZBQkFo5qAAhsMAAoJEGu9DlcdrjdR4C0L
 /RcjolEjoZW8VsyxWtXazQPnaRvzZ4vhmGOsCPr2BPtMlSwDzTlri8BBG1/3t/DNK4JLuwEj
 OAIE3fkkm+UG4Kjud6aNeraDI52DRVCSx6xff3bjmJsJJMb12mWglN6LjdF6K+PE+OTJUh2F
 dOhslN5C2kgl0dvUuevwMgQF3IljLmi/6APKYJHjkJpu1E6luZec/lRbetHuNFtbh3xgFIJx
 2RpgVDP4xB3f8r0I+y6ua+p7fgOjDLyoFjubRGed0Be45JJQEn7A3CSb6Xu7NYobnxfkwAGZ
 Q81a2XtvNS7Aj6NWVoOQB5KbM4yosO5+Me1V1SkX2jlnn26JPEvbV3KRFcwV5RnDxm4OQTSk
 PYbAkjBbm+tuJ/Sm+5Yp5T/BnKz21FoCS8uvTiziHj2H7Cuekn6F8EYhegONm+RVg3vikOpn
 gao85i4HwQTK9/D1wgJIQkdwWXVMZ6q/OALaBp82vQ2U9sjTyFXgDjglgh00VRAHP7u1Rcu4
 l75w1xInsg==
In-Reply-To: <aIKZnSuTXn9thrf7@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2025 1:37 PM, Sean Christopherson wrote:
> On Mon, Jul 14, 2025, Peter Zijlstra wrote:
>> --- a/arch/x86/kvm/vmx/vmenter.S
>> +++ b/arch/x86/kvm/vmx/vmenter.S
>> @@ -361,6 +361,10 @@ SYM_FUNC_END(vmread_error_trampoline)
>>   
>>   .section .text, "ax"
>>   
>> +#ifndef CONFIG_X86_FRED
>> +
>>   SYM_FUNC_START(vmx_do_interrupt_irqoff)
>>   	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
>>   SYM_FUNC_END(vmx_do_interrupt_irqoff)
>> +
>> +#endif
> 
> This can go in the previous patch, "x86/fred: KVM: VMX: Always use FRED for IRQs
> when CONFIG_X86_FRED=y".
> 

I'm going to test patch 13~15, plus this change in patch 16.

BTW, there is a declaration for vmx_do_interrupt_irqoff() in
arch/x86/kvm/vmx/vmx.c, so we'd better also do:

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6945,7 +6945,9 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, 
u64 *eoi_exit_bitmap)
         vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
  }

+#ifndef CONFIG_X86_FRED
  void vmx_do_interrupt_irqoff(unsigned long entry);
+#endif
  void vmx_do_nmi_irqoff(void);

  static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)

